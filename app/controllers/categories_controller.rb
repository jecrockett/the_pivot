class CategoriesController < ApplicationController

  def index
    @categories = Category.all
    #random cause for featured cause on bottom of page
    @cause = Cause.find(rand(Cause.all.pluck(:id).sample))
  end

  def show
    @category = Category.find(params[:id])
  end
end
