class Listing < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  belongs_to :subcategory
  validates :title, :description, :price, :location, :category, :subcategory, :user, presence: true
  validates :shippable, :publish, inclusion: { in: [true, false] }
end
