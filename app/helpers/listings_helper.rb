module ListingsHelper
  def willing_to_ship?(listing)
    if listing.shippable
      return "Willing to ship"
    else
      return "Not willing to ship"
    end
  end
end