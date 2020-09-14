class Product < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :orders
  has_many :comments, as: :commentable
 
end
