module ApplicationHelper
  def home_url
    root_url.sub(/\/\Z/, "") # remove trailing / for SEO purposes
  end

  def marketplace_page?
    controller_name == "marketplace" && action_name == "index"
  end

  def home_page?
    controller_name == "users" && action_name == "home"
  end

  def messages_page?
    controller_name == "messages"
  end

  def offers_page?
    controller_name == "offers"
  end

  def offers_index?
    controller_name == "offers" && action_name == "index"
  end

  def page_title(name)
    content_for(:title) { name + " | bonsai list"}
  end

  def marketplace_or_listings
    return user_marketplace_path(@user) if @user
    return marketplace_path if controller_name == "marketplace"
    return listings_path if controller_name == "listings"
  end

  def current_user_listing?
    @listing.user == current_user
  end

  def set_controller_name
    return Rails.env.test? ? "marketplace" : controller_name
  end
end
