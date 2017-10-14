class Address < ApplicationRecord
  belongs_to :user

  validates :city, :country, :state, :pincode, presence: true
end
