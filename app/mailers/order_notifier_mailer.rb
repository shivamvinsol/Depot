class OrderNotifierMailer < ApplicationMailer
  default from: MAIL[:from]

  def order_received(order)
    @order = order
    @line_items = LineItem.includes(product: :images).where(order_id: @order.id)
    # @line_items = @order.line_item # what is better to use?

    @line_items.each do |line_item|
      line_item.product.images.each.with_index do |image, index|
        image_extension = image.name.split('.').last
        product_image = File.read("#{Rails.root.to_s}/public/images/" + line_item.product.images[index].name)
        if index.zero?
          attachments.inline[line_item.product.title + "." + image_extension] = product_image
        else
          attachments[line_item.product.title + index.to_s + "." + image_extension] = product_image
        end
      end
    end
    mail to: @order.email, subject: 'Order Confirmation'
  end
end
