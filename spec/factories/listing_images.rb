# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :listing_image do
    listing nil
    image "MyString"
  end
end
