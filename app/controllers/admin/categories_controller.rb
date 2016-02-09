module Admin
  class CategoriesController < Admin::BaseController
    before_action :set_categories, only: [:edit, :index, :create]
    before_action :set_category, only: [:edit, :update, :destroy]

    def index
      @category = Category.new
    end

    def create
      @category = Category.new(category_params)
      if @category.save
        flash[:success] = "New category #{@category.title} created"
        redirect_to admin_categories_path
      else
        flash[:error] = "Something went wrong, dreamer."
        render "index"
      end
    end

    def edit
    end

    def update
      if @category.update(category_params)
        flash[:success] = "#{@category.title} updated"
        redirect_to admin_categories_path
      else
        render "edit"
      end
    end

    def destroy
      @category.destroy
      flash[:success] = "#{@category.title} removed"
      redirect_to admin_categories_path
    end

    private

    def set_category
      @category = Category.find(params[:id])
    end

    def set_categories
      @categories = Category.all
    end

    def category_params
      params.require(:category).permit(:title)
    end
  end
end
