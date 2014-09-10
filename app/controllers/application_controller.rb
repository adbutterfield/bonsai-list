class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_up_path_for(resource)
    user_root_path
  end

  # after_sign_out_path_for TODO

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:firstname, :lastname, :postcode, :email, :password, :password_confirmation, :remember_me, address_attributes: [ :id, :user_id, :city, :state, :postcode, :country ]) }

    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :firstname, :lastname, :postcode, :email, :password, :remember_me) }
    # TOTO implement and test update address
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:firstname, :lastname, :postcode, :email, :password, :password_confirmation, :current_password) }
  end
end
