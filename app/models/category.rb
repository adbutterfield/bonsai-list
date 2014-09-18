class Category < ActiveRecord::Base
  has_many :listings, inverse_of: :category
end
