class AdminController < ApplicationController
  before_action :check_user_is_admin

  def index
    @total_order = Order.count
  end

  def show_reports
    @orders = Order.by_date(5.days.ago)
  end

  private
    def check_user_is_admin
      @user = User.find(session[:user_id])
      if @user.role != "admin"
        redirect_to store_url, notice: 'You dont have priviledges to view this'
      end
    end
end
