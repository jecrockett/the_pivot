class ApplicationController < ActionController::Base
  helper_method :current_user, :current_admin?, :current_user_id, :get_other_admins, :active_causes, :cause_owner?, :clear_attempted_donation, :login_redirect
  protect_from_forgery with: :exception

  def clear_attempted_donation
    session[:attempted_donation] = nil
  end

  def login_redirect(user)
    if session[:attempted_donation]
      redirect_to session[:attempted_donation]
    elsif current_admin?
      redirect_to admin_dashboard_path
    else
      redirect_to user_path(user)
    end
  end

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    else
      @current_user = nil
    end
  end

  def current_user_id
    current_user ? current_user.id : nil
  end

  def current_user_username
    current_user ? current_user.username : nil
  end

  def current_user_guard
    render file: "/public/404" unless current_user.id == params[:id].to_i
  end

  def current_admin?
    current_user && current_user.admin?
  end

  def get_other_admins(cause)
     unless cause.other_admins.empty?
       admins = cause.other_admins.map { |admin| User.find_by(email: admin).username }
     end
     admins.nil? ? result = "None" : result = admins.join(", ")
     result
   end

  # def active_causes
  #   Cause.where(category_id: params[:id], current_status: "active")
  # end

  def secondary_admin
    Cause.find(params[:id]).other_admins.include?(current_user.email) if current_user
  end

  def cause_owner?
    params[:user] == current_user_username || secondary_admin
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
  end

end
