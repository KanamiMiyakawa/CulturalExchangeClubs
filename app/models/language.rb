class Language < ApplicationRecord

  #イベント使用言語
  has_many :event_languages
  has_many :events, through: :event_languages

  #参加者
  has_many :participants, dependent: :destroy
end
