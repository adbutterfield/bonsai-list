class UsersController < ApplicationController

  def home
    @listings = current_user.current_listings
  end
end
