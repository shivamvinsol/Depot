class Image < ApplicationRecord
  belongs_to :product, required: false
  validates :content_type, inclusion: { in: %w(image/jpeg image/png image/gif) }

  # validates :name, format: { with: /\.(jpg|png|gif)\Z/, message: 'not a valid image' }
end
