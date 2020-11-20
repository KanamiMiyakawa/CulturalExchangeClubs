class EventLanguage < ApplicationRecord
  belongs_to :event
  belongs_to :language
end
