module ApplicationHelper
  def home_url
    root_url.sub(/\/\Z/, "") # remove trailing / for SEO purposes
  end

  def marketplace_page?
    # controller_name == "marketplace"
    current_page?(controller: 'marketplace')
  end

  def home_page?
    # controller_name == "users" && action_name == "home"
    current_page?(controller: 'users', action: 'home')
  end

  def page_title(name)
    content_for(:title) { name << " | Bonsai List"}
  end
end
