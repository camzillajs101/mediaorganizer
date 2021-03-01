class UsersController < ApplicationController
  def show
    @user = User.where(username: params[:username]).first # FIRST!! LOL

    if current_user.id == @user.id # ooh I'm just too smart
      render 'private' # for this part I mean
    else
      render 'public'
    end
  end

  def upload
    uploaded_file = params[:file]
    table = CSV.parse(uploaded_file.read)
    successful = 0

    case params[:type]  # should DRY this up in the future
    when "images"
      table.each do |row|
        next if row[0] == "id" # headers
        image = current_user.images.new(url: row[1], title: row[2], favorite: row[3], mediatype: row[6])
        if image.save
          successful += 1
        end
      end
    when "categories"
      table.each do |row|
        next if row[0] == "id"
        category = current_user.categories.new(title: row[1], favorite: row[2])
        if category.save
          successful += 1
        end
      end
    when "jointable" # (maybe) acceptably bug-free (just don't interrupt the indexes)
      table.each do |row|
        next if row[0] == "category_id"
        category_start = params[:category_start].to_i - 1
        image_start = params[:images_start].to_i - 1
        category = Category.find(category_start+row[0].to_i)
        image = Image.find(image_start+row[1].to_i)
        next if !(category.user_id == current_user.id && image.user_id == current_user.id) # user owns both records
        next if category.images.exists?(image.id) # record exists already
        category.images << image # create record
      end
    end
  end

  def download
    @user = User.where(username: params[:username]).first
    # send_file(@user.to_csv, filename: "categories.csv", type: "text/csv")
  end
end
