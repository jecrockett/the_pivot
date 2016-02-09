class SessionsController < ApplicationController
  after_action :clear_attempted_donation, only: [:create]

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email])
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

end
