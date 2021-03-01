class Image < ApplicationRecord
  has_and_belongs_to_many :categories
  belongs_to :user

  validates :url, presence: true
end
