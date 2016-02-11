class SessionsController < ApplicationController
  after_action :clear_attempted_donation, only: [:create]

  def new
  end

  def create
    user = set_user(request)
    if user.oauth_token || user.authenticate(params[:session][:password])
      login_user(user)
    else
      flash[:error] = "Invalid username or password"
      redirect_to login_path
    end

    # if request.env["omniauth.auth"]
    #   user = User.from_omniauth(request.env["omniauth.auth"])
      # twitter_login(user)
    #
    #   session[:user_id] = user.id
    #   flash[:notice] = "Start dreaming, #{current_user.username} :-)"
    #   login_redirect(user)
    # else
    #   user = User.find_by(email: params[:session][:email])
    #   if user && user.authenticate(params[:session][:password])
    #     session[:user_id] = user.id
    #     flash[:notice] = "Start dreaming, #{current_user.username} :-)"
    #     login_redirect(user)
    #   else
    #     flash[:error] = "Invalid username or password"
    #     redirect_to login_path
    #   end
    # end
  end

  def destroy
    session.clear
    current_user
    redirect_to root_path
  end

  private

  def set_user(req)
    req.env["ominauth.auth"] ? User.from_omniauth(req.env["omniauth.auth"])
                             : User.find_by(email: params[:session][:email])
  end

  def login_user(user)
    session[:user_id] = user.id
    flash[:notice] = "Start dreaming, #{current_user.username} :-)"
    login_redirect(user)
  end

end
