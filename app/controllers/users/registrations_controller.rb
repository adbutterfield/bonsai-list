class Users::RegistrationsController < Devise::RegistrationsController
  before_action :set_address_variables, only: :new

  def new
    super
  end

  private
    def set_address_variables
      @city_name    = location.city
      @state_name   = location.state
      @country_name = location.country
      @post_code    = location.postal_code
      @latitude     = location.latitude
      @longitude    = location.longitude
    end
end