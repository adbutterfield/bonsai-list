# Read about factories at https://github.com/thoughtbot/factory_girl
require 'faker'

FactoryGirl.define do
  pass = Faker::Internet.password(8)
  factory :user do
    email { Faker::Internet.email }
    password pass
    password_confirmation pass
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    address
  end
end
