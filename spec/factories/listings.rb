# Read about factories at https://github.com/thoughtbot/factory_girl
require 'faker'

FactoryGirl.define do
  factory :listing do
    headline "MyString"
    description "MyText"
    price "9.99"
    shippable true
    publish true
    remove false
    sale_type "sale"
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
    user
    after(:build) do |listing, eval|
        listing.listing_images << FactoryGirl.build(:listing_image, listing: listing)
    end

    # TODO test geocode

    category
  end
end
