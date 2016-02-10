class DonationsController < ApplicationController
  before_action :confirm_current_user, only: [:create]

  def create
    @donation = Donation.new(donation_params)
    if @donation.save
      flash[:success] = "Thank you for making this dream come true!"
      redirect_to user_cause_path(@donation.cause.user.username, @donation.cause)
    else
      @cause = Cause.find(params[:donation][:cause_id])
      flash.now[:error] = "Invalid donation, please try again"
      redirect_to user_cause_path(@cause.user.username, @cause)
    end
  end

  private

  def donation_params
    params.require(:donation).permit(:amount, :user_id, :cause_id, :cause_name)
  end

  def confirm_current_user
    unless current_user
      flash[:error] = "Please create an account or login to donate"
      session[:attempted_donation] = URI(request.referrer).path
      redirect_to new_user_path
    end
  end
end
