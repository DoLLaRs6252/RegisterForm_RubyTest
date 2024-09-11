class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    # Fetch all unique subjects for the dropdown filter
    @subjects = ['HTML', 'CSS', 'JavaScript']
  
    # Filter users by subject if a subject is selected
    if params[:subject].present?
      @users = User.where(subject: params[:subject])
    else
      @users = User.all
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to user_delete_path
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to users_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :phone, :gender, :birthday, :subject)
  end
end
