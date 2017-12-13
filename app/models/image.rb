class Image < ApplicationRecord
  belongs_to :product, required: false

  validates :content_type, inclusion: { in: %w(image/jpeg image/png image/gif), message: "not valid image file" }
  # FIXME: jquery handle??
  # validates :name, uniqueness: { scope: :product_id, case_sensitive: false, message: "should be unique" }, allow_blank: true
end
