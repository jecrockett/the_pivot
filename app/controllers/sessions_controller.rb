require 'JSON'

class SessionsController < ApplicationController
  after_action :clear_attempted_donation, only: [:create]

  def new
  end

  def create
    if request.env["omniauth.auth"]
      user = User.from_omniauth(request.env["omniauth.auth"])
      session[:user_id] = user.id
      flash[:notice] = "Start dreaming, #{current_user.username} :-)"
      login_redirect(user)
    else
      user = User.find_by(email: params[:session][:email])
      if user && user.authenticate(params[:session][:password])
        session[:user_id] = user.id
        flash[:notice] = "Start dreaming, #{current_user.username} :-)"
        login_redirect(user)
      else
        flash[:error] = "Invalid username or password"
        redirect_to login_path
      end
    end
  end

  def destroy
    session.clear
    current_user
    redirect_to root_path
  end
end
