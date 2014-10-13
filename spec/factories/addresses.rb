# Read about factories at https://github.com/thoughtbot/factory_girl
require 'faker'

FactoryGirl.define do
  factory :address do
    city { Faker::Address.city }
    state { Faker::Address.state }
    postcode { Faker::Address.postcode }
    country { Faker::Address.country }
    latitude "38.7992"
    longitude "-123.0172"
    user nil
  end
end
