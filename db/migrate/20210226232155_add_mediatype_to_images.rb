class AddMediatypeToImages < ActiveRecord::Migration[6.0]
  def change
    add_column :images, :mediatype, :string
  end
end
