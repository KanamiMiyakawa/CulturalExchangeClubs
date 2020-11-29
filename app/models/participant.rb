class Participant < ApplicationRecord
  before_create :check_pending
  before_create :check_the_rest

  belongs_to :user
  belongs_to :event
  belongs_to :event_language
  belongs_to :group

  private

  def check_pending
    self.pending = true if self.event.permission?
  end

  def check_the_rest
    if EventLanguage.find_by(event_id:self.event_id, language_id:self.language_id).max - self.event.participants.where(language_id: self.language_id).count == 0
      errors.add :base, 'イベントが満席になりました'
      throw :abort
    end
  end
end
