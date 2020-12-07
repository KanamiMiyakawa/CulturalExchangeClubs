class Event < ApplicationRecord
  #geocoder
  geocoded_by :address, latitude: :lat, longitude: :lon
  after_validation :geocode, if: :address_changed?

  #データ加工
  before_validation :online_delete_address
  before_update :change_participants_not_pending, if: [:permission_changed?, Proc.new { |event| event.permission == false}]
  before_validation :add_user_id, if: Proc.new { |event| event.organizer_id.present? }

  #バリデーション
  validates :name,  presence: true, length: { maximum: 50 }
  validate  :date_not_before_today
  validates :content,  presence: true
  validates :online, inclusion: { in: [true, false] }
  validates :permission, inclusion: { in: [true, false] }
  validates :guest_allowed, inclusion: { in: [true, false] }
  validate  :real_need_address
  validate  :has_language?
  validate  :duplicate_language?
  validate  :include_organizer_ids

  after_validation :remove_unnecessary_messages

  #アソシエーション
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

  def real_need_address
    errors.add(:address, :real_need_address) if self.online == false && self.address.blank?
  end

  def date_not_before_today
    errors.add(:schedule, :date_not_before_today) if schedule.nil? || schedule < Time.zone.now
  end

  def include_organizer_ids
    errors.add(:organizer_id, :include_ids) unless self.group.organizers.pluck(:id).include?(self.organizer_id)
  end

  def add_user_id
    self.user_id = self.organizer.user_id
  end

  def has_language?
    errors.add(:base, :has_language) if self.event_languages.blank?
  end

  def duplicate_language?
    language_ids = self.event_languages.map(&:language_id)
    errors.add(:base, :duplicate_language) if language_ids != language_ids.uniq
  end

  def remove_unnecessary_messages
    errors.messages.delete(:user)
    errors.messages.delete(:organizer)
  end

end
