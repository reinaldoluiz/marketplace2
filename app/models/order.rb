class Order < ApplicationRecord
  belongs_to :user
  belongs_to :product
  has_many :comments, as: :commentable
end
