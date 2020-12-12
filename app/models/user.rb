class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

  geocoded_by :address, latitude: :lat, longitude: :lon
  after_validation :geocode, if: :address_changed?

  # ActiveStorage
  has_one_attached :avatar

  validates :name,  presence: true, length: { maximum: 255 }
  validates :email, presence: true, length: { maximum: 255 }, uniqueness: true,
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  # validates :introduction, length: { maximum: 400 }
  validates :address, length: {maximum: 255}

  #一般ユーザ
  has_many :members, dependent: :destroy
  has_many :groups, through: :members
  #グループのオーガナイザー権限
  has_many :organizers, dependent: :destroy
  has_many :organizing_groups, through: :organizers, source: :group
  #オーナー
  has_many :own_groups, dependent: :destroy, foreign_key: :owner_id, class_name: 'Group'

  #参加者
  has_many :participants, dependent: :destroy
  has_many :events, through: :participants
  #イベントのオーガナイザー
  has_many :organizing_events, dependent: :destroy, foreign_key: :user_id, class_name: 'Event'
end
