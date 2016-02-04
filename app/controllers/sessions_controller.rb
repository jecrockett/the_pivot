class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: params[:session][:username])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = "Start dreaming, #{current_user.username} :-)"
      login_redirect(user)
    else
      flash[:error] = "Invalid username or password"
      redirect_to login_path
    end
  end

  def destroy
    session.clear
    redirect_to root_path
  end

  def login_redirect(user)
    if session[:want_to_checkout]
      redirect_to new_order_path
    elsif current_admin?
      redirect_to admin_dashboard_path
    else
      redirect_to user_path(user)
    end
  end
end
