class Order < ApplicationRecord
  belongs_to :user
  belongs_to :product
  has_many :comments, as: :commentable
  enum status: { open: 0, bought: 10, closed: 20 }
end
