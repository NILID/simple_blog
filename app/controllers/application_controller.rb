class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    if current_user
      raise
    else
      session[:requested_url] = request.url
      redirect_to root_url, alert: t('shared.access_denied')
    end
  end

  protected
    def configure_permitted_parameters
      attributes = %i[login email]
      devise_parameter_sanitizer.permit(:sign_up, keys: attributes)
      devise_parameter_sanitizer.permit(:account_update, keys: attributes)
    end
end
