class Event < ApplicationRecord
  geocoded_by :address, latitude: :lat, longitude: :lon
  after_validation :geocode, if: :address_changed?

  belongs_to :organizer
  belongs_to :group
  has_many :event_languages
  accepts_nested_attributes_for :event_languages, allow_destroy: true, reject_if: :all_blank
  has_many :languages, through: :event_languages
end
