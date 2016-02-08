class Users::CausesController < ApplicationController
  before_action :valid_cause_owner?, only: [:edit, :update]

  def show
    redirect_to root_path unless show_cause?
    @cause = Cause.find(params[:id])
    @donation = Donation.new
  end

  def index
  end

  def new
    @cause = Cause.new
  end

  def create
    @cause = Cause.new(cause_params)
    if @cause.save
      @cause.other_admins << params[:cause][:other_admins]
      flash[:notice] = "You dreamt about a #{@cause.title}"
      redirect_to user_cause_path(current_user, @cause)
    else
      flash.now[:notice] = "Uh oh! You're not done dreaming. :`("
      render :new
    end
  end

  def edit
    @cause = Cause.find(params[:id])
  end

  def update
    @cause = Cause.find(params[:id])
    update_cause_attribues
    if URI(request.referrer).path == admin_dashboard_path
      redirect_to admin_dashboard_path
    else
      redirect_to user_cause_path(@cause.user, @cause)
    end
  end

  private

    def cause_params
      params.require(:cause).permit(:title,
                                    :description,
                                    :goal,
                                    :category_id,
                                    :user_id,
                                    :other_admins,
                                    :status)
    end

    def valid_cause_owner?
      cause = Cause.find(params[:id])
      redirect_to root_path unless (current_user_id == cause.user_id) || (current_user.role == 'admin')
    end

    def update_cause_attribues
      @cause.update_attributes(cause_params)
      admins = @cause.other_admins.concat([params[:cause][:other_admins]])
      @cause.update_column(:other_admins, admins) if email_found?
    end

    def email_found?
      User.find_by(email: params[:cause][:other_admins])
    end

    def show_cause?
      Cause.find(params[:id]).current_status == 'active' || cause_owner?
    end
end
