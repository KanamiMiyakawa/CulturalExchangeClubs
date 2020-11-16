class Group < ApplicationRecord
  has_many :members, dependent: :destroy
  has_many :users, through: :members

  after_create :add_organizer_to_users

  def add_organizer_to_users
    user = self.users.first
    user.update!(organizer:true) unless user.organizer
  end
end
