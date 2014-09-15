class Users::RegistrationsController < Devise::RegistrationsController

  def new
    build_resource({})
    self.resource.address = Address.new(city: location.city, state: location.state, country: location.country, postcode: location.postal_code, latitude: location.latitude, longitude: location.longitude)
    respond_with self.resource
  end

end