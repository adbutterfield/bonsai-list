class Category < ActiveRecord::Base
  has_many :listings, inverse_of: :category
  has_many :subcategories, inverse_of: :category
end
