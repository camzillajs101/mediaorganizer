class CreateImagesAndCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :images do |t|
      t.string :url
      t.string :title
      t.boolean :favorite

      t.timestamps
    end

    create_table :categories do |t|
      t.string :title
      t.boolean :favorite

      t.timestamps
    end

    create_table :categories_images, id: false do |t|
      t.belongs_to :category, index: true
      t.belongs_to :image, index: true
    end
  end
end
