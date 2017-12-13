class Order < ApplicationRecord
  has_many :line_items, dependent: :destroy
  PAYMENT_TYPES = ['Check', 'Credit Card', 'Purchase Order']
  validates :name, :address, :email, presence: true
  validates :pay_type, inclusion: PAYMENT_TYPES

  belongs_to :user

  after_commit :send_order_confirmation_mail

  # FIXME:: time.now vs time.current
  scope :by_date, ->(from = Time.current, to = Time.current) { where created_at: from.to_datetime.midnight..to.to_datetime.end_of_day }

  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      # item.cart_id = nil  # this deletes associations
      line_items << item
    end
  end

  def total_price
    line_items.to_a.sum { |line_item| line_item.total_price }
  end

  def send_order_confirmation_mail
    OrderMailer.confirmed(self).deliver
  end
end
