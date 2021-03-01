class CategoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @categories = current_user.categories.order(id: :asc)
  end

  def show
    @category = Category.find(params[:id])
    @images = @category.images.where(mediatype: "image")
    @videos = @category.images.where(mediatype: "video")
    @links = @category.images.where(mediatype: "link")

    if @category.user_id != current_user.id
      redirect_to categories_path
    end
  end

  def new
    @category = current_user.categories.new
  end

  def create
    @category = current_user.categories.new(category_params)

    if (@category.save)
      redirect_to @category
    else
      render :new
    end
  end

  private
    def category_params
      params.require(:category).permit(:title, :favorite)
    end
end
