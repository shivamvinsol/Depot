class SessionsController < ApplicationController
  skip_before_action :authorize

  def create
    user = User.find_by(name: params[:name])
    if user and user.authenticate(params[:password])
      reset_session # reset session after login (cart will be gone!!!!)
      session[:user_id] = user.id
      if user.role == "admin"
        redirect_to admin_report_path and return
      end

      redirect_to store_path # not admin
    else
      redirect_to login_url, alert: t(:invalid_credentials)
    end
  end

  def destroy
    session.clear #clear all session
    # session[:user_id] = nil
    redirect_to store_url, notice: 'Logged out'
  end
end
