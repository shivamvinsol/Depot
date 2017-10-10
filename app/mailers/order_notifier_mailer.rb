class OrderNotifierMailer < ApplicationMailer

  default from: 'shivam jain <hackmait@gmail.com>'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_notifier_mailer.received.subject
  #
  def received(order)
    @order = order
    mail to: @order.email, subject: "Order Confirmation"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_notifier_mailer.shipped.subject
  #
  def shipped
  @order = order
  mail to: @order.email, subject: "Order shipped" 
  end
end
