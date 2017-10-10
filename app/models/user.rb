class User < ApplicationRecord
  validates :name , presence: true, uniqueness: true
  has_secure_password
  before_destroy :check_not_admin_account
  before_update :check_not_admin_account
  after_destroy :ensure_an_user_remains
  after_create :send_welcome_email

  validates :email, presence: true
  validates :email, uniqueness: true, format: {
    with: /\A[0-9a-z_\.]{2,20}@[0-9a-z]{2,20}(\.[a-z]{2,3}){1,2}\Z/i, # abc@gmail.com / ab@gmail.co.in
    message: "invalid"
  }, allow_blank: true

  private

    def ensure_an_user_remains
      if User.count.zero?
        raise "Can't delete the last user"
      end
    end

    def send_welcome_email
      NewUserNotifier.welcome(self).deliver
    end

    def check_not_admin_account
      if self.email =~ /admin@depot.com/i
        raise "Admin account, Restricited Access!"
      end
    end
end
