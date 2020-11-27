class Member < ApplicationRecord
  before_create :check_pending
  belongs_to :user
  belongs_to :group

  validates :user_id, uniqueness: { scope: :group_id }

  private

  def check_pending
    self.pending = true if self.group.permission?
  end

  # def owner_not_destroyed
  #   if self.group.owner == self.user
  #     errors.add :base, 'オーナーはメンバーから削除できません'
  #     throw :abort
  #   end
  # end
end
