class Users::CausesController < ApplicationController
  before_action :valid_cause_owner?, only: [:edit, :update]

  def show
    @cause = Cause.find(params[:id])
    @amount_raised = Donation.where(cause_id: @cause.id).sum(:amount) || 0
    @donation = Donation.new
    @donation_count = Donation.where(cause_id: @cause.id).count
    @total_supporters = Donation.where(cause_id: @cause.id).pluck(:user_id).uniq.count
  end

  def index
  end

  def new
    @cause = Cause.new
  end

  def create
    @cause = Cause.new(cause_params)
    if @cause.save
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
    @cause.update_attributes(cause_params)
    redirect_to user_cause_path(@cause.user, @cause)
  end

  private
    def cause_params
      params.require(:cause).permit(:title, :description, :goal, :category_id)
    end

    def valid_cause_owner?
      @cause = Cause.find(params[:id])
      redirect_to root_path unless current_user_id == @cause.user_id
    end
end
