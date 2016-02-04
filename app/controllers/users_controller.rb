class UsersController < ApplicationController
  # helper :headshot
  before_action :current_user_guard, only: [:edit]

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
    @user = current_user
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
end
