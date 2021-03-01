class ImagesController < ApplicationController
  before_action :authenticate_user!

  def index
    @images = current_user.images

    case params[:sort]
    when "favorite"
      @all = @images.where(favorite: true).order(id: :asc)
    when "asc"
      @all = @images.order(id: :asc)
    when "desc"
      @all = @images.order(id: :desc)
    when "abc"
      @all = @images.order(title: :asc)
    else
      @all = @images.order(id: :asc)
    end

    @images = @all.where(mediatype: "image")
    @videos = @all.where(mediatype: "video")
    @links = @all.where(mediatype: "link")
  end

  def show
    @image = Image.find(params[:id])

    verify_ownership
  end

  def new
    @image = current_user.images.new
  end

  def create
    @image = current_user.images.new(image_params.except(:category))

    if (@image.save)
      image_params[:category].each do |f|
        if f[1] == "1"
          Category.find(f[0]).images << @image
        end
      end
      redirect_to @image
    else
      render :new
    end
  end

  def edit
    @image = Image.find(params[:id])

    verify_ownership
  end

  def update
    @image = Image.find(params[:id])

    image_params[:category].each do |f|
      @category = Category.find(f[0])
      if @image.categories.exists?(@category.id)
        @category.images.delete(@image) if f[1] == "0"
      else
        @category.images << @image if f[1] == "1"
      end
    end

    if @image.update(image_params.except(:category))
      redirect_to images_path
    else
      render :edit
    end
  end

  def destroy
    @image = Image.find(params[:id])
    verify_ownership
    @image.destroy

    redirect_to images_path
  end

  private
    def image_params
      params.require(:image).permit! # MWAHAHAHAHAHAHA
    end
    def verify_ownership
      if @image.user_id != current_user.id
        redirect_to images_path
      end
    end
end
