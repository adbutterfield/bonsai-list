class Address < ActiveRecord::Base
  belongs_to :user, inverse_of: :address

  validates :city, :state, :postcode, :country, presence: true

  geocoded_by :full_address
  after_validation :geocode

  def full_address
    [self.city, self.state, self.postcode, self.country].join(', ')
  end
end
