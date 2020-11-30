class EventLanguage < ApplicationRecord
  before_update :participants_exist if :language_id_changed?
  before_update :max_smaller_than_participants if :max_changed?

  belongs_to :event
  belongs_to :language

  #参加者
  has_many :participants, dependent: :destroy

  private

  def participants_exist
    if self.participants.present?
      self.event.errors.add :base, 'すでにユーザが登録している言語は変更できません、言語かイベント自体を削除してください'
      throw :abort
    end
  end

  def max_smaller_than_participants
    if self.max < self.participants.count
      self.event.errors.add :base, '現在の登録人数より少ない最大登録者数は設定できません'
      throw :abort
    end
  end
end
