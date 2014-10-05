class UsersController < ApplicationController
  before_action :authenticate_user!

  def home
    @listings = current_user.listings.order(created_at: :desc)
  end
end
