class Address < ActiveRecord::Base
  belongs_to :user, inverse_of: :address

  validates :city, :state, :postcode, :country, presence: true
end
