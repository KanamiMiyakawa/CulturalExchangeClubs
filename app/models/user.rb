class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

  geocoded_by :address, latitude: :lat, longitude: :lon
  after_validation :geocode, if: :address_changed?

  #一般ユーザ
  has_many :members, dependent: :destroy
  has_many :groups, through: :members
  #オーガナイザー
  has_many :organizers, dependent: :destroy
  has_many :organizing_groups, through: :organizers, source: :group
  #オーナー
  has_many :own_groups, dependent: :destroy, foreign_key: :owner_id, class_name: 'Group'

  #参加者
  has_many :participants, dependent: :destroy
  has_many :events, through: :participants
end
