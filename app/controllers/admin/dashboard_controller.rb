class Admin::DashboardController < Admin::BaseController
  def show
    @active_causes = Cause.where(status: 1)
    @pending_causes = Cause.where(status: 0)
    @users = User.all
    @donations = Donation.all
    render "admin/dashboard"
  end
end
