#FIXED FIXME: move this to seperate file in app/validators so that it can be used in other classes too
require_relative '../validators/url_validator.rb'

class Product < ApplicationRecord
  # attr_accessor :image

  has_many :line_items, dependent: :restrict_with_error
  has_many :carts, through: :line_items
  has_one :image, dependent: :delete
  accepts_nested_attributes_for :image

  belongs_to :category, counter_cache: :count # for parent need callback
  before_validation :set_title, :set_discount_price

  validates :title, :image, :price, presence: true
  validates :price, numericality: { greater_than_or_equal_to: :discount_price },
            allow_blank: true
  validates :title, uniqueness: true

  # validates :image_url, url: true, allow_blank: true # changed to image (file)

  #fixed FIXME:
  validate :description, :ensure_word_count_in_range
  validate :price,  :ensure_price_greater_than_dicount_price
  validates :discount_price, numericality: true, allow_blank: true
  validates :category_id, presence: { message: "should be selected" }

#FIXED FIXME: ABC vs abc
  validates :permalink, uniqueness: { case_sensitive: false }, format: {
    #FIXED FIXME: config/initializers/constant.rb REGEXP[:permalink] = //
    #FIXED FIXME: Read about initializers directory and files in this directory. what special it has
    with: REGEXP[:permalink]
  }
# FIXME: user validates length, use tokanizer option

  scope :enabled, -> { where enabled: true } # scope for enabled products

  after_create :increment_count

  def self.latest
    Product.order(:updated_at).last
  end

  private
    def ensure_price_greater_than_dicount_price
      # so that it runs only when price and discounted price both are present, and we dont face nil class errors.
      if price && discount_price && price < discount_price
        errors.add(:price, "Can't be lower than discounted price")
      end
    end

    def ensure_word_count_in_range
      unless description.scan(/\w+/).count.between?(5, 10)
        errors.add(:description, "should be between 5-10 words")
      end
    end

    def set_title
      if title.blank?
        self.title = 'abc'
      end
      #FIXED FIXME: prefer to use blank? and present? instead of == "" or empty? or nil? read the difference
      # self.title = 'abc' if title.empty?
      #FIXED FIXME: avoid inline if statements
    end

    def set_discount_price
      #fixed FIXME: use single if statement
      if discount_price.blank? && price.present?
        self.discount_price = self.price
      end
    end

    def increment_count
      parent_category_id = Category.find(category_id).parent_category_id
      if parent_category_id.present?
        Category.increment_counter(:count, parent_category_id)
      end
    end

end
