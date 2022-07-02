class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :get_providers

  def get_providers
    if current_user && current_user.role == User::PROVIDER
      @providers = current_user.providers
    else
      @providers = Provider.all
    end
  end

  protected
   def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:email, :password, :confirm_password, :name, :role) }
   end
end
