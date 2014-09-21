class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  http_basic_authenticate_with name: ENV['LOGIN_NAME'], password: ENV['LOGIN_PASS']

  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_up_path_for(resource)
    user_root_path
  end

  # after_sign_out_path_for TODO

  def after_sign_in_path_for(resource)
    user_root_path
  end

  def location
    if user_signed_in?
      @location = current_user.address
    else
      if Rails.env.test? || Rails.env.development?
        @location ||= Geocoder.search("76.103.52.107").first
      else
        @location ||= request.location
      end
    end
  end

  def current_user?(user)
    current_user == user
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:firstname, :lastname, :postcode, :email, :password, :password_confirmation, :remember_me, address_attributes: [ :id, :user_id, :city, :state, :postcode, :country, :longitude, :latitude ]) }

    # TODO implement and test update address
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:firstname, :lastname, :postcode, :email, :password, :password_confirmation, :current_password) }
  end
end
