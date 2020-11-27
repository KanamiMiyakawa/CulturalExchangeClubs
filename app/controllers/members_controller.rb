class MembersController < ApplicationController
  before_action :authenticate_user!
  def create
    current_user.members.create!(group_id:params[:group_id])
    redirect_to group_path(params[:group_id]), notice: 'グループ加入リクエストを送信しました'
  end

  def destroy
    member = Member.find(params[:id])
    organizer = Organizer.find_by(user_id:member.user_id, group_id:member.group_id)
    organizer.destroy! if organizer.present?
    member.destroy!
    redirect_to group_path(params[:group_id]), notice: 'グループから脱退しました'
  end
end
