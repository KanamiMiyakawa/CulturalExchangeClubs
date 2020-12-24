class EventLanguage < ApplicationRecord
  before_update :participants_exist, if: :language_id_changed?
  before_update :max_smaller_than_participants, if: :max_changed?

  validates :max, numericality: { greater_than:0, less_than_or_equal_to:500 }

  belongs_to :event
  belongs_to :language

  #参加者
  has_many :participants, dependent: :destroy

  private

  def participants_exist
    if self.participants.present?
      self.event.errors.add :base, :not_deleted
      throw :abort
    end
  end

  def max_smaller_than_participants
    if self.max < self.participants.count
      self.event.errors.add :base, :max_too_small
      throw :abort
    end
  end
end
