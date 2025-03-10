class UsersController < ApplicationController
  before_action :logged_in_user, only: [ :index, :edit, :update, :destroy ]
  before_action :correct_user, only: [ :edit, :update ]
  before_action :admin_user, only: :destroy

  def index
    @users = User.page(params[:page]).per(10)
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.page(params[:page]).per(10)
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user # users_path(user)
    else
      render "new"
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params) # update_attributes has been removed
      flash[:success] = "Profile updated successfully"
      redirect_to @user # users_path(user)
    else
      render "edit"
    end
  end

  def destroy
    User.find(params[:id]).destroy # @user = User.find(params[:id]) if @user.destroy etc...
    flash[:success] = "User was successfully deleted"
    redirect_to users_url
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  # Before filters
  # logged_in_user moved to application controller


  # Confirms the correct user. To redirect users trying to edit another user’s proﬁle
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  # Confirms admin user
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
