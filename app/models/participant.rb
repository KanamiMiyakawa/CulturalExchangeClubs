class Participant < ApplicationRecord
  belongs_to :user
  belongs_to :event
  belongs_to :language
end
