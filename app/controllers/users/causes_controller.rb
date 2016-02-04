class Users::CausesController < ApplicationController
  def show
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
      flash[:notice] = "You dreamt about a #{@cause.title}"
      redirect_to user_cause_path(current_user, @cause)
    else
      flash.now[:notice] = "Uh oh! You're not done dreaming. :`("
      render :new
    end
  end

  def update
  end

  private

    def cause_params
      params.require(:cause).permit(:title, :description, :goal, :category_id)
    end
end
