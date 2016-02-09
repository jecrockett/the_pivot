class UsersController < ApplicationController
  before_action :valid_user?, only: [:edit, :update]
  after_action :clear_attempted_donation, only: [:create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Start dreaming, #{current_user.username} :-)"
      login_redirect(@user)
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

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

  def valid_user?
    user = User.find(params[:id])
    redirect_to root_path unless current_user_id == user.id
  end
end
