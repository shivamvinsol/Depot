class Image < ApplicationRecord
  belongs_to :product, required: false

  validates :name, format: { with: /\.(jpg|png|gif)\Z/, message: 'not a valid format' }
end
