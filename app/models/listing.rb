class Listing < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  belongs_to :subcategory
  validates :title, :description, :price, :location, :category, :subcategory, :user, presence: true
  validates :shippable, :publish, :remove, inclusion: { in: [true, false] }

  scope :postable, -> { where(remove: false) }

  def published?
    self.publish ? "Yes" : "No"
  end
end
