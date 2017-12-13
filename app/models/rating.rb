class Rating < ApplicationRecord
  belongs_to :product
  belongs_to :user
  validates :user_id, uniqueness: { scope: :product_id }
  validates :rating, inclusion: { in: (0.5..5).step(0.5) }
end
