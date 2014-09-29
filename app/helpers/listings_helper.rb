module ListingsHelper

  def pricing_table_button
    if user_signed_in?
      if @listing.user == current_user
        return link_to 'Edit listing', edit_listing_path(@listing), :class => "button"
      end
      if current_user.not_already_inquired?(@listing)
        if @listing.is_offer?
          return "<a class='button' href='#' data-reveal-id='interestedModal'>Make offer!</a>".html_safe
        else
          return "<a class='button' href='#' data-reveal-id='interestedModal'>I'm interested!</a>".html_safe
        end
      else
        return "<a class='button disabled'>Inquiry sent!</a>".html_safe
      end
    else
      return link_to 'Sign in to inquire!', new_user_session_path, :class => 'button'
    end
  end
end