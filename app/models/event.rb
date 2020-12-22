class Event < ApplicationRecord
  #geocoder
  geocoded_by :address, latitude: :lat, longitude: :lon
  after_validation :geocode, if: :address_changed?

  #データ加工
  before_validation :online_delete_address
  before_update :change_participants_not_pending, if: [:permission_changed?, Proc.new { |event| event.permission == false}]
  before_validation :add_user_id, if: Proc.new { |event| event.organizer_id.present? }

  #バリデーション
  validates :name,  presence: true, length: { maximum: 255 }
  validate  :date_not_before_today
  validates :content,  presence: true, length: { maximum: 800 }
  validates :online, inclusion: { in: [true, false] }
  validates :permission, inclusion: { in: [true, false] }
  validates :guest_allowed, inclusion: { in: [true, false] }
  validates :address, length: { maximum: 255 }
  validate  :real_need_address
  validate  :has_language?
  validate  :duplicate_language?
  validate  :include_organizer_ids
  # ActiveStorage
  validate  :thumbnail_type_and_syze
  validate  :images_type_syze_length

  after_validation :remove_unnecessary_messages

  # ActiveStorage
  has_one_attached :thumbnail
  has_many_attached :images

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

  #翻訳
  has_many :translations

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

  def thumbnail_type_and_syze
    if self.thumbnail.attached?
      if !thumbnail.blob.content_type.in?(%('image/jpeg image/png'))
        thumbnail.purge
        errors.add(:thumbnail, :jpeg_or_png)
      elsif thumbnail.blob.byte_size > 5.megabytes
        thumbnail.purge
        errors.add(:thumbnail, :under_5mb)
      end
    end
  end

  def images_type_syze_length
    if self.images.attached?
      if images.length > 4
        images.purge
        errors.add(:images, :length)
      else
        images.each do |image|
          if !image.blob.content_type.in?(%('image/jpeg image/png video/mp4'))
            image.purge
            errors.add(:images, :jpeg_or_png_or_mp4)
          elsif image.blob.byte_size > 30.megabytes
            image.purge
            errors.add(:images, :under_30mb)
          end
        end
      end
    end
  end

end
