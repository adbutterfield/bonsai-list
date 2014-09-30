module MarketplaceHelper
  def no_listings_message
    "<p class='text-center'>No listings found</p>".html_safe
  end

  def not_current_user(user)
    current_user != user
  end
end
