Geocoder.configure({
  # For geocoding with bing
  # lookup: :bing,
  # key: ENV['BING_GEOCODE_ID'],
  cache: Rails.cache,
  :http_proxy => ENV['QUOTAGUARD_URL'],
  :timeout => 5
})