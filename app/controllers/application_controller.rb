class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # http_basic_authenticate_with name: ENV['LOGIN_NAME'], password: ENV['LOGIN_PASS']

  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_up_path_for(resource)
    user_root_path
  end

  # after_sign_out_path_for TODO

  def after_sign_in_path_for(resource)
    user_root_path
  end

  def visitor_location
    Struct.new("VisitorLocation", :latitude, :longitude)
    Struct::VisitorLocation.new(JSON.parse(cookies[:location])['latitude'], JSON.parse(cookies[:location])['longitude'])
  end

  def current_user?(user)
    current_user == user
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:first_name, :last_name, :postcode, :email, :password, :password_confirmation, :remember_me, :avatar, :avatar_cache, address_attributes: [ :id, :user_id, :city, :state, :postcode, :country, :longitude, :latitude ]) }

    # TODO implement and test update address
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:first_name, :last_name, :postcode, :email, :password, :password_confirmation, :current_password, :avatar, :avatar_cache, :remove_avatar, address_attributes: [ :id, :user_id, :city, :state, :postcode, :country, :longitude, :latitude ]) }
  end
end