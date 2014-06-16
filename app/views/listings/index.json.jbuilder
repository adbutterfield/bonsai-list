json.array!(@listings) do |listing|
  json.extract! listing, :id, :title, :description, :price, :location, :shippable, :publish, :remove
  json.url listing_url(listing, format: :json)
end
