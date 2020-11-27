class Event < ApplicationRecord
  geocoded_by :address, latitude: :lat, longitude: :lon
  after_validation :geocode, if: :address_changed?

  belongs_to :organizer
  belongs_to :group

  #使用言語
  has_many :event_languages, dependent: :destroy
  accepts_nested_attributes_for :event_languages, allow_destroy: true, reject_if: proc { |attributes| attributes['max'].blank? }
  has_many :languages, through: :event_languages

  #イベント参加者
  has_many :participants, dependent: :destroy
  has_many :users, through: :participants
end
