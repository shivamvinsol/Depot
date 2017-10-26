class AdminController < ApplicationController
  before_action :ensure_user_is_admin

  def index
    @total_order = Order.count
  end

  def show_reports
    @orders = Order.by_date(5.days.ago)
  end

  def show_categories
    @categories = Category.all
  end

  def get_orders_between_dates
    arguments = order_params
    # FIXME: Order.select("products.price, line_items.quantity").joins(line_items: :product).by_date("2017-10-25") how to do this!!!!
    @order_between_dates = Order.by_date(arguments[:from_date], arguments[:to_date])
    respond_to do |format|
      format.json { render json: { orders: @order_between_dates }}
    end
  end

  private
    def ensure_user_is_admin
      @user = User.find(session[:user_id])
      if @user.blank? || @user.role != "admin"
        redirect_to store_url, notice: 'You dont have priviledges to view this'
      end
    end

    def order_params
      params.permit(:from_date, :to_date)
    end
end
