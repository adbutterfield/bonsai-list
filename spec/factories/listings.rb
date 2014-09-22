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
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
    user

    # TODO test geocode

    category
  end
end
