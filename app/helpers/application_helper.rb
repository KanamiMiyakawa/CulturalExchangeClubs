module ApplicationHelper
  def chk_member_status(user_id)
    case user_id
    when @group.owner.id
      t('helpers.status.owner')
    when *@organizers.pluck(:user_id)
      t('helpers.status.organizer')
    when *@pending_users.pluck(:user_id)
      t('helpers.status.pending')
    when *@members.pluck(:user_id)
      t('helpers.status.member')
    else
      t('helpers.status.guest')
    end
  end
end
