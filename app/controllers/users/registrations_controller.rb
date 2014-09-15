class Users::RegistrationsController < Devise::RegistrationsController
  before_action :set_address_variables, only: :new

  def new
    super
  end

  private
    def set_address_variables
      @address      = request.location
      @city_name    = @address.city
      @state_name   = @address.state
      @country_name = @address.country
      @post_code    = @address.postal_code
      @latitude, @longitude = cookies[:location].split(',').map(&:to_f)
    end
end