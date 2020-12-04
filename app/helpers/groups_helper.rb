module GroupsHelper
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
      "未加入(ゲスト)"
    end
  end
end
