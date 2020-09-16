class Product < ApplicationRecord
  validates :name, :category, :price,:description, presence: true
  validates :name, uniqueness: true
  belongs_to :user
  has_one_attached :image
  has_many :orders
  has_many :comments, as: :commentable
 
end
