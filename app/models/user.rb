class User < ApplicationRecord
  validates :name , presence: true, uniqueness: true
  has_secure_password
  before_destroy :check_not_admin_account
  before_update :check_not_admin_account
  after_destroy :ensure_an_user_remains
  after_create :send_welcome_email

  validates :email, presence: true
  #fixed FIXME: ignore case in uniqueness
  validates :email, uniqueness: { case_sensitive: true },
            format: { with: REGEXP[:email], message: "invalid" }, allow_blank: true

  has_many :orders
  has_many :line_items, through: :orders

  has_one :address
  accepts_nested_attributes_for :address

  # validates_associated :address # automatically validated, how?
  # validates :address, presence: true

  # has_many :line_items, -> { group 'product_id' }, through: :orders

  private

    def ensure_an_user_remains
      if User.count.zero?
        raise "Can't delete the last user"
      end
    end

    def send_welcome_email
      WelcomeUser.welcome(self).deliver
    end

    def check_not_admin_account
      #fixed FIXME: don't use regexp
      if self.email.downcase == "admin@depot.com"
        raise "Admin account, Restricited Access!"
      end
    end
end
