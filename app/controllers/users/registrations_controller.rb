class Users::RegistrationsController < Devise::RegistrationsController
  def new
    address = Geocoder.search(cookies[:location])[0]
    # street_number  = @address.address_components[0]['long_name']
    # street_name  =  @address.address_components[1]['long_name']
    @city_name  = address.address_components[2]['long_name']
    @state_name = address.address_components[4]['long_name']
    @country_name = address.address_components[5]['long_name']
    @post_code = address.address_components[6]['long_name']
    @address = "#{city_name}, #{state_name}, #{@post_code}, #{country_name}"
    super
  end
end