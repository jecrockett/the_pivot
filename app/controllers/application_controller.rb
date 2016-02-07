class ApplicationController < ActionController::Base
  helper_method :current_user, :current_admin?, :current_user_id, :get_other_admins, :active_causes, :cause_owner?
  protect_from_forgery with: :exception

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

  def get_other_admins(cause)
    admins = []
    unless cause.other_admins.empty?
      cause.other_admins.each { |admin| admins << User.find_by(email: admin).username }
    end
    admins.empty? ? result = "None" : result = admins.join(", ")
    result
  end

  def active_causes
    Cause.where(category_id: params[:id], current_status: "active")
  end

  def cause_owner?
    params[:user].to_i == current_user_id
  end

end
