class Admin::DashboardController < Admin::BaseController
  def show
    @active_causes = Cause.where(current_status: "active")
    @pending_causes = Cause.where(current_status: "pending")
    @users = User.all
    @donations = Donation.last(30)
    render "admin/dashboard"
  end
end
