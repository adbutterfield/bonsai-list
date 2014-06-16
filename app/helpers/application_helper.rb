module ApplicationHelper
  def home_url
    root_url.sub(/\/\Z/, "") # remove trailing / for SEO purposes
  end

  def marketplace_page?
    controller_name == "products" && action_name == "marketplace"
  end

  def home_page?
    controller_name == "users" && action_name == "home"
  end
end
