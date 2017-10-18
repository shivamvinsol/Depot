class Address < ApplicationRecord
  belongs_to :user, required: false

  validates :city, :country, :state, :pincode, presence: true
end
