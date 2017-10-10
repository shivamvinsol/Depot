class UrlValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\.(gif|jpg|png)\Z/i
      record.errors[attribute] << "is not valid"
    end
  end
end

class Product < ApplicationRecord
  has_many :line_items, dependent: :restrict_with_error
  has_many :carts, through: :line_items
  # has_and_belongs_to_many :carts
  # before_destroy :ensure_not_referenced_by_any_line_item
  before_validation :set_title, :set_discount_price


  validates :title, :description, :image_url, :price, presence: true
  validates :price, numericality: { greater_than_or_equal_to: :discount_price },
            allow_blank: true
  validates :title, uniqueness: true
  validates :image_url, url: true, allow_blank: true
  validates :description, length: { in: 5..10 }, allow_blank: true
  validate :price,  :ensure_price_greater_than_dicount_price
  validates :permalink, uniqueness: true, format: {
    with: /\A(([a-z0-9])+-){2,}([a-z0-9])+\Z/i
  }
  validates :discount_price, numericality: true, allow_blank: true

  def self.latest
    Product.order(:updated_at).last
  end

  private
    def ensure_not_referenced_by_any_line_item
      byebug
      if line_items.empty?
        return true
      else
        errors.add(:base, 'Line Items present')
        return false
      end
    end

    def ensure_price_greater_than_dicount_price
      # so that ut runs only when price and discounted price both are present, and we dont face nil class errors.
      if price && discount_price && price < discount_price
        errors.add(:price, "Can't be lower than discounted price")
      end
    end

    def set_title
      self.title = 'abc' if title.empty?
    end

    def set_discount_price
      if discount_price.nil?
        self.discount_price = self.price unless  price.nil?
      end
    end
end
