class OrderMailer < ApplicationMailer
  default from: Rails.application.secrets[:mail_from]

  def confirmed(order)
    @order = order
    @line_items = LineItem.includes(product: :images).where(order_id: @order.id)

    @line_items.each do |line_item|
      line_item.product.images.each_with_index do |image, index|
        product_image = File.read("#{Rails.root.to_s}/public/images/#{line_item.product.id}/" + image.name)
        if index.zero?
          attachments.inline[image.name] = product_image
        else
          attachments[image.name] = product_image
        end
      end
    end
    mail to: @order.email, subject: I18n.t('order_mailer.confirmed.subject')
  end

  def all_user_orders(user)
    @user = user
    @orders = user.orders

    headers['X-SYSTEM-PROCESS-ID'] = Process.pid

    I18n.with_locale(@user.language) do
      mail to: @user.email, subject: I18n.t('order_mailer.all_user_orders.subject')
    end

  end

end
