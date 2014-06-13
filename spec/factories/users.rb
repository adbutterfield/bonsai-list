# Read about factories at https://github.com/thoughtbot/factory_girl
require 'faker'

FactoryGirl.define do
  factory :user do |f|
    f.email { Faker::Internet.email }
    f.password { Faker::Internet.password(8) }
    f.firstname { Faker::Name.first_name }
    f.lastname { Faker::Name.last_name }
    f.postcode { Faker::Address.postcode }
  end
end
