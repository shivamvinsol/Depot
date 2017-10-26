class ConsolidatedOrderMailer < ApplicationMailer
  default from: MAIL[:from]

  def all_user_orders(user)
    @user = user
    @orders = user.orders

    headers['X-SYSTEM-PROCESS-ID'] = Process.pid

    I18n.with_locale(@user.language) do
      mail to: @user.email, subject: I18n.t('consolidated_order_mailer.all_user_orders.subject')
    end

  end
end
