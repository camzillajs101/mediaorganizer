class UsersController < ApplicationController
  def show
    @user = User.where(username: params[:username]).first # FIRST!! LOL

    if current_user.id == @user.id # ooh I'm just too smart
      render 'private'
    else
      render 'public'
    end
  end

  def upload
    # uploaded_file = params[:file]
    # table = CSV.parse(uploaded_file.read)
    # puts table[1][1]
    # File.open(Rails.root.join('public', 'uploads', uploaded_file.original_filename), 'wb') do |file|
    #   file.write(uploaded_file.read)
    # end
  end

  def download
    @user = User.where(username: params[:username]).first
    # send_file(@user.to_csv, filename: "categories.csv", type: "text/csv")
  end
end
