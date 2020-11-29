class Language < ApplicationRecord

  #イベント使用言語
  has_many :event_languages
  has_many :events, through: :event_languages
end
