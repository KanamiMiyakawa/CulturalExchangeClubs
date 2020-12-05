module ApplicationHelper
  def chk_member_status(user_id)
    case user_id
    when @group.owner.id
      "オーナー"
    when *@organizers.pluck(:user_id)
      "オーガナイザー"
    when *@pending_users.pluck(:user_id)
      "参加保留中"
    when *@members.pluck(:user_id)
      "メンバー"
    else
      "ゲスト(非メンバー)"
    end
  end
end
