class CategoriesController < ApplicationController

  before_action :set_category, only: [:show, :edit, :update]
  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_param)
    if @category.save
      redirect_to categories_path
    else
      render 'new'
    end
  end

  def index
    @categories = Category.where(parent_category_id: nil)
  end

  def update
    if @category.update(category_param)
      redirect_to categories_path
    else
      render 'edit'
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy

    redirect_to categories_path
  end

  private

    def category_param
      params.require(:category).permit(:name, :parent_category_id)
    end

    def set_category
      @category = Category.find(params[:id])
    end
end
