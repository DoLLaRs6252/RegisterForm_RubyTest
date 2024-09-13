class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      update_users_cache
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    # กำหนดคีย์แคชที่เป็นเอกลักษณ์สำหรับข้อมูลทั้งหมด
    all_users_cache_key = "users/all"
    # ตรวจสอบแคช
    Rails.logger.info("Cache key: #{all_users_cache_key}")
    # ดึงข้อมูลทั้งหมดจากแคช
    @all_users = Rails.cache.fetch(all_users_cache_key, expires_in: 5.minutes) do
      Rails.logger.info("Cache miss for key: #{all_users_cache_key}")
      users = User.all.to_a
      Rails.logger.info("Storing all users data in cache for key: #{all_users_cache_key}")
      users
    end

    @users = @all_users

    if params[:subject].present?
      @users = @users.select { |user| user.subject == params[:subject] }
    end

    if params[:search].present?
      search_term = params[:search].downcase
      @users = @users.select { |user| 
        user.first_name.downcase.include?(search_term) || 
        user.last_name.downcase.include?(search_term) 
      }
    end

    Rails.logger.info("Cache hit for key: #{all_users_cache_key}") if @users.present?
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    update_users_cache
    redirect_to users_path
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      update_users_cache
      redirect_to users_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :phone, :gender, :birthday, :subject)
  end

  def update_users_cache
    Rails.cache.delete("users/all")
    Rails.logger.info("Cache cleared for key: users/all")

    # Optionally, you can force a fresh cache population
    Rails.cache.fetch("users/all", expires_in: 5.minutes) do
      users = User.all.to_a
      Rails.logger.info("Storing all users data in cache for key: users/all")
      users
    end
  end
end
