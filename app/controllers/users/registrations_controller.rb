class Users::RegistrationsController < Devise::RegistrationsController
  def new
    @address = Geocoder.search(session[:coordinates])[0].formatted_address
    super
  end
end