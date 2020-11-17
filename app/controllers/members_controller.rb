class MembersController < ApplicationController
  def create
    group = Group.find(params[:group_id])
    if group.permission
      current_user.members.create!(group_id:group.id, pending: true)
    else
      current_user.members.create!(group_id:group.id)
    end
    redirect_to group_path(group.id), notice: 'グループ加入リクエストを送信しました'
  end

  def destroy
    member = Member.find(params[:id])
    organizer = Organizer.find_by(user_id:member.user_id, group_id:member.group_id)
    organizer.destroy! if organizer.present?
    member.destroy!
    redirect_to group_path(params[:group_id]), notice: 'グループから脱退しました'
  end
end