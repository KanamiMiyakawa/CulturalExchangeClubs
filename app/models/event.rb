class Event < ApplicationRecord
  geocoded_by :address, latitude: :lat, longitude: :lon
  after_validation :geocode, if: :address_changed?
  
  belongs_to :organizer
  belongs_to :group
end
