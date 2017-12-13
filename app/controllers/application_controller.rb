class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_i18n_locale_from_params
  before_action :authorize
  before_action :check_inactivity_time
  around_action :get_response_time

  private

    def set_i18n_locale_from_params
      if params[:locale]
        if I18n.available_locales.map(&:to_s).include?(params[:locale])
          I18n.locale = params[:locale]
        else
          flash.now[:notice] = "#{params[:locale]} translation not available"
          logger.error flash.now[:notice]
        end
      else
        if session[:user_id]
          I18n.locale = User.find(session[:user_id]).language
        end
      end
    end

    def default_url_options
      { locale: I18n.locale }
    end

    def authorize
      unless User.find_by(id: session[:user_id])
        redirect_to login_url, notice: 'Please login'
      end
    end

    #fixed FIXME: add this in request headers
    def get_response_time
      before_response_time = Time.now
      yield
      @response_time = Time.now - before_response_time
      response.headers['X-Responded-In'] = @response_time
    end

    def check_inactivity_time
      if cookies.has_key?(:last_activity)
        if Time.now - cookies[:last_activity].to_time > 5.hours
          session[:user_id] = nil
          redirect_to store_url, notice: 'Logged out'
        end
        cookies[:last_activity] = Time.now
      else
        cookies[:last_activity] = {
          value: Time.now,
          expires: 1.year.from_now
        }
      end
    end
end
