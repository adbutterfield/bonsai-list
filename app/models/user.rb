class User < ActiveRecord::Base
  has_one :address
  validates_associated :address
  has_many :listings, -> { where(remove: false) }
  has_many :posted_listings, -> { where(remove: false, publish: true) }, class_name: 'Listing'

  accepts_nested_attributes_for :address, allow_destroy: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :firstname, :lastname, presence: true
  validates :email, uniqueness: { case_sensitive: false }

end
