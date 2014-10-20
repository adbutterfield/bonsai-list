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

  def all_listings?
    ((controller_name == "listings"  && action_name == "index") || controller_name == "marketplace") && params[:category_id] == nil
  end

  def page_title(name)
    content_for(:title) { name + " | bonsai list"}
  end

  def no_listings_message
    "<p class='text-center no-listing-message-margin'>No listings found</p>".html_safe
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

  def notifcation_count
    current_user.new_messages_count + current_user.new_offers_count
  end

  def new_messages_notice
    if user_signed_in? && current_user.new_messages_count > 0
      return push_notice(current_user.new_messages_count)
    end
  end

  def new_offers_notice
    if user_signed_in? && current_user.new_offers_count > 0
      return push_notice(current_user.new_offers_count)
    end
  end

  def new_notification_notice(display={})
    if (user_signed_in? && current_user.new_messages_count > 0) || (user_signed_in? && current_user.new_offers_count > 0)
      if display[:mobile]
        return mobile_push_notification(notifcation_count)
      else
        return push_notice(notifcation_count)
      end
    end
  end

  def push_notice(count)
    "<span class='noti-container'><span class='noti-bubble'>#{ count }</span></span>".html_safe
  end

  def mobile_push_notification(count)
    return   "<div class='noti-container'><div class='noti-bubble'>#{ count }</div></div>".html_safe
  end
end
