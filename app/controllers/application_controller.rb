class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :get_categories
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :terms_of_service])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :country_code])
  end

  def get_categories
    @categories = Category.all
  end
end
