class CategoriesController < ApplicationController

  def index
    @categories = Category.all
    #random cause for featured cause on bottom of page
    @cause = Cause.all.first
  end

  def show
    @category = Category.find(params[:id])
  end
end
