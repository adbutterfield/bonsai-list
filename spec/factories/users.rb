# Read about factories at https://github.com/thoughtbot/factory_girl
require 'faker'

FactoryGirl.define do
  pass = Faker::Internet.password(8)
  factory :user do
    email { Faker::Internet.email }
    password pass
    password_confirmation pass
    firstname { Faker::Name.first_name }
    lastname { Faker::Name.last_name }

    factory :user_with_address do
      after(:create) { |user| create_list(:address, 1, user: user) }
    end
  end
end
