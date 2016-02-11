class Users::CausesController < ApplicationController
  before_action :valid_cause_owner?, only: [:edit, :destroy]
  before_action :valid_update?, only: [:update]

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
      flash[:success] = "You dreamt about a #{@cause.title}"
      redirect_to user_cause_path(current_user.username, @cause)
    else
      flash.now[:error] = "Uh oh! You're not done dreaming. :`("
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
      redirect_to user_cause_path(@cause.user.username, @cause)
    end
  end

  def destroy
    @cause = Cause.find(params[:id])
    backfill_donations(@cause)
    @cause.delete
    redirect_to user_path(User.find_by(username: params[:user]))
  end

  private

    def cause_params
      params.require(:cause).permit(:title,
                                    :description,
                                    :goal,
                                    :category_id,
                                    :user_id,
                                    :other_admins,
                                    :current_status,
                                    :image_url)
    end

    def valid_cause_owner?
      cause = Cause.find(params[:id])
      redirect_to root_path unless cause_owner? || (current_user.role == 'admin')
    end

    def valid_update?
      cause = Cause.find(params[:id])
      redirect_to root_path unless approved? || (current_user.role == 'admin')
    end

    def approved?
      params[:user].to_i == current_user_id || secondary_admin
    end

    def update_cause_attribues
      data = cause_params
      data[:user_id] = "#{@cause.user.id}"
      @cause.update_attributes(data)
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
