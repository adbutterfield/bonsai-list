class Users::SessionsController < Devise::SessionsController

  def destroy
    cookies[:location] = nil
    super
  end
end