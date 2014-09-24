module ListingsHelper
  def willing_to_ship?(listing)
    if listing.shippable
      return "Willing to ship"
    else
      return "Not willing to ship"
    end
  end

  def pricing_table_button
    if user_signed_in?
      if current_user.not_already_inquired?(@listing)
        if @listing.sale_type == "sale"
          return "<a class='button' href='#' data-reveal-id='interestedModal'>I'm interested!</a>".html_safe
        else
          return "<a class='button' href='#' data-reveal-id='interestedModal'>Make offer!</a>".html_safe
        end
      else
        return "<a class='button disabled'>Inquiry sent!</a>".html_safe
      end
    else
      return link_to 'Sign in to inquire!', new_user_session_path, :class => 'button'
    end
  end
end