# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :address do
    city "MyString"
    state "MyString"
    postcode "MyString"
    country "MyString"
    user nil
  end
end
