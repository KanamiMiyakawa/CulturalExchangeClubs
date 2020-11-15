class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable
  geocoded_by :address, latitude: :lat, longitude: :lon
  after_validation :geocode, if: :address_changed?

  has_many :members, dependent: :destroy
  has_many :groups, through: :members
end
