class Users::SessionsController < Devise::SessionsController
  after_action :clear_location_cookie, only: :destroy

  private
    def clear_location_cookie
      cookies[:location] = nil
    end
end
