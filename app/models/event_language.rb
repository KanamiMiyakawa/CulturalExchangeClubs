class EventLanguage < ApplicationRecord
  belongs_to :event
  belongs_to :language

  #参加者
  has_many :participants, dependent: :destroy
end
