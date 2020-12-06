class Event < ApplicationRecord
  geocoded_by :address, latitude: :lat, longitude: :lon
  after_validation :geocode, if: :address_changed?

  before_validation :online_delete_address
  before_update :change_participants_not_pending, if: [:permission_changed?, Proc.new { |event| event.permission == false}]

  #イベントが所属するグループ
  belongs_to :organizer
  belongs_to :group

  #使用言語
  has_many :event_languages, dependent: :destroy
  accepts_nested_attributes_for :event_languages, allow_destroy: true, reject_if: proc { |attributes| attributes['max'].blank? }
  has_many :languages, through: :event_languages

  #イベント参加者
  has_many :participants, dependent: :destroy
  has_many :users, through: :participants
  #イベント自体の管理者
  belongs_to :user

  private

  def change_participants_not_pending
    self.participants.update_all(pending:false)
  end

  def online_delete_address
    self.address = "" if self.online == true && self.address.present?
  end
end
