class ApplicationController < ActionController::Base
  helper_method :current_user, :current_admin?, :current_user_id
  protect_from_forgery with: :exception
  before_action :store_location

  def store_location
    session[:forwarding_url] = request.path if request.get?
  end

  def redirect_path(default)
    session[:attempted_donation] || default
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_user_id
    current_user ? current_user.id : nil
  end

  def current_user_guard
    render file: "/public/404" unless current_user.id == params[:id].to_i
  end

  def current_admin?
    current_user && current_user.admin?
  end
end
