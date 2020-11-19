class Organizer < ApplicationRecord
  belongs_to :user
  belongs_to :group

  has_many :events, dependent: :destroy

  validates :user_id, uniqueness: { scope: :group_id }
end
