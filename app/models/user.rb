class User < ActiveRecord::Base
  has_many :listings

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :firstname, :lastname, :postcode, presence: true

  def current_listings
    Listing.where(user_id: self.id, remove: false)
  end
end
