class Group < ApplicationRecord
  #一般ユーザ
  has_many :members, dependent: :destroy
  has_many :users, through: :members
  #オーガナイザー
  has_many :organizers, dependent: :destroy
  has_many :organized_users, through: :organizers, source: :user
  #オーナー
  belongs_to :owner, class_name: 'User'
  #イベント
  has_many :events, dependent: :destroy
end
