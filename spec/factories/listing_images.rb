# Read about factories at https://github.com/thoughtbot/factory_girl
FactoryGirl.define do
  factory :listing_image do
    listing nil
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'photos', 'test.png')) }
  end
end
