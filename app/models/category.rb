class Category < ApplicationRecord
  has_and_belongs_to_many :images
  belongs_to :user

  validates :title, presence: true
end
