class CategoriesController < ApplicationController

  def index
    @categories = Category.all
    #random cause for featured cause on bottom of page
    @cause = Cause.all.first
  end

  def show
    @category = Category.find(params[:id])
    @causes = (Cause.active_causes_for_category(params)).paginate(:page => params[:page]).order('id ASC')
    # byebug
  end
end
