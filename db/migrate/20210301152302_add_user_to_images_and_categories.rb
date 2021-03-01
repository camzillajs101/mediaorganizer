class AddUserToImagesAndCategories < ActiveRecord::Migration[6.0]
  def change
    add_reference :images, :user, index: true
    add_reference :categories, :user, index: true
  end
end
