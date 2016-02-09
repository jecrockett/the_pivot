class ApplicationController < ActionController::Base
  helper_method :current_user, :current_admin?, :current_user_id, :get_other_admins, :active_causes, :cause_owner?
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

  def backfill_donations(cause)
    donations = Donation.where(cause_id: cause.id)
    holder = Cause.find_by(title: "Dead Dream")
    donations.each {|donation| donation.update_column(:cause_id, holder.id)}
  end

  def backfill_causes(user)
    causes = Cause.where(user_id: user.id)
    holder = User.find_by(email: "gone@heaven.com")
    causes.each { |cause| package_cause_for_death(cause, holder) }
  end

  def package_cause_for_death(cause, holder)
    backfill_donations(cause)
    cause.update_column(:user_id, holder.id)
    cause.update_column(:current_status, "deleted")
    # cause.delete
  end

end
