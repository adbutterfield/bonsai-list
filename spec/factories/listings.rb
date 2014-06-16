# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :listing do
    title "MyString"
    description "MyText"
    price "9.99"
    shippable true
    publish true
    remove false
    user
    location { user.postcode }
    category
    subcategory
  end
end
