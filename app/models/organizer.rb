class Organizer < ApplicationRecord
  belongs_to :user
  belongs_to :group

  has_many :events, dependent: :destroy

  before_create :member_pending_chk

  validates :user_id, uniqueness: { scope: :group_id }

  private

  def member_pending_chk
    member = Member.find_by(user_id: self.user_id, group_id: self.group_id)
    member.update!(pending: false) if member.pending?
  end

end
