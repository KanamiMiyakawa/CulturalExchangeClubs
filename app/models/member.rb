class Member < ApplicationRecord
  before_create :check_pending
  before_destroy :deny_event_request
  before_destroy :change_member_to_guest
  before_destroy :not_destroy_organizer

  belongs_to :user
  belongs_to :group

  validates :user_id, uniqueness: { scope: :group_id }

  private

  def check_pending
    self.pending = true if self.group.permission? && self.group.owner_id != self.user.id
  end

  #メンバーを削除するとき、ゲスト不可のイベント参加を削除する
  def deny_event_request
    events = self.group.events.where('schedule >= ?', Time.zone.now).where(guest_allowed:false)
    Participant.where(user_id:self.user_id, event_id:events.pluck(:id)).destroy_all if events.present?
  end

  #メンバーを削除するとき、ゲスト可のイベント参加があれば、その元メンバーをゲストにする
  def change_member_to_guest
    events = self.group.events.where('schedule >= ?', Time.zone.now).where(guest_allowed:true)
    Participant.where(user_id:self.user_id, event_id:events.pluck(:id)).update_all(guest:true) if events.present?
  end

  # オーガナイザーの場合削除できない
  def not_destroy_organizer
    throw :abort if Organizer.find_by(user_id: self.user_id, group_id: self.group_id).present?
  end

end
