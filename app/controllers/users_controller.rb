class UsersController < ApplicationController
  before_action :valid_user?, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      path = redirect_path(user_path(@user))
      session[:attempted_donation] = nil
      session[:user_id] = @user.id
      redirect_to path
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to @user
    else
      render :edit
    end
  end

  private

  def redirect_back_or(default)
    session[:attempted_donation] || default
  end

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

  def valid_user?
    user = User.find(params[:id])
    redirect_to root_path unless current_user_id == user.id
  end
end
