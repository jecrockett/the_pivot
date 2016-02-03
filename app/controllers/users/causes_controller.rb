class Users::CausesController < ApplicationController
  def show
    @cause = Cause.find(params[:id])
  end

  def index
  end

end
