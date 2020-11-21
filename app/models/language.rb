class Language < ApplicationRecord
  has_many :event_languages
  has_many :events, through: :event_languages
end
