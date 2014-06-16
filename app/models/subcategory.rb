class Subcategory < ActiveRecord::Base
  belongs_to :category
  has_many :listings, inverse_of: :subcategory
end
