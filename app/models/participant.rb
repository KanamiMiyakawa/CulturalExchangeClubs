class Participant < ApplicationRecord
  before_create :check_pending
  before_create :check_the_rest
  before_create :check_organizer

  validates :user_id, uniqueness: { scope: :event_id }
  validate  :guest_not_allowed, if: Proc.new { |participant| participant.guest? }
  validate  :past_event

  belongs_to :user
  belongs_to :event
  belongs_to :event_language
  belongs_to :group

  private

  def check_pending
    self.pending = true if self.event.permission?
  end

  def check_the_rest
    event_language = self.event_language
    if event_language.max - event_language.participants.count == 0
      errors.add :base, :no_rest
      throw :abort
    end
  end

  def check_organizer
    throw :abort if self.user_id == self.event.user_id
  end

  def guest_not_allowed
    throw :abort unless self.event.guest_allowed
  end

  def past_event
    throw :abort if self.event.schedule < Time.zone.now
  end
end
