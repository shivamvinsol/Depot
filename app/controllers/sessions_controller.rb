class SessionsController < ApplicationController
  skip_before_action :authorize
  def new
  end

  def create
    user = User.find_by(name: params[:name])
    if user and user.authenticate(params[:password])
      session[:user_id] = user.id
      if user.role == "admin"
        redirect_to '/admin/reports' and return
      end

      redirect_to store_path # not admin
    else
      redirect_to login_url, alert: 'Invalid name/password combination'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to store_url, notice: 'Logged out'
  end
end
