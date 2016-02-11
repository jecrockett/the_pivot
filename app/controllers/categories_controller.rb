class CategoriesController < ApplicationController

  def index
    @categories = Category.all
    # random cause for featured cause on bottom of page
    @cause = Cause.all.first
    # creates an array of category cause counts to be used in javascript
    @amounts = Category.all.map{|category| category.causes.count}
    gon.amount = @amounts
  end

  def show
    @category = Category.find(params[:id])
    # pagination
    @causes = (Cause.active_causes_for_category(params)).paginate(:page => params[:page]).order('id ASC')
  end
end
