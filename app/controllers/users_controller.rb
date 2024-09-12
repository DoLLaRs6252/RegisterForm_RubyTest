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
    # Predefined subjects: HTML, CSS, JavaScript
    @subjects = ['HTML', 'CSS', 'JavaScript']
  
    # Start with all users
    @users = User.all
  
    # Filter by subject if one is selected
    if params[:subject].present?
      @users = @users.where(subject: params[:subject])
    end
  
    # Search by name if a search term is provided
    if params[:search].present?
      search_term = "%#{params[:search]}%"
      @users = @users.where("first_name LIKE ? OR last_name LIKE ?", search_term, search_term)
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
