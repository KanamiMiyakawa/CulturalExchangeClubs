class Group < ApplicationRecord
  before_update :change_members_not_pending, if: [:permission_changed?, Proc.new { |group| group.permission == false}]

  validates :name,  presence: true
  validates :permission, inclusion: { in: [true, false] }

  #一般ユーザ
  has_many :members, dependent: :destroy
  has_many :users, through: :members
  #オーガナイザー
  has_many :organizers, dependent: :destroy
  has_many :organized_users, through: :organizers, source: :user
  #オーナー
  belongs_to :owner, class_name: 'User'
  #イベント
  has_many :events, dependent: :destroy
  #イベント参加者
  has_many :participants, dependent: :destroy

  private

  def change_members_not_pending
    self.members.update_all(pending:false)
  end
end
