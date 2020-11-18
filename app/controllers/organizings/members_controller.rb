class Organizings::MembersController < ApplicationController
  before_action :authenticate_user!
  before_action :any_organizer, only: [:accept_all_members]

  before_action :set_member, only: [:update, :deny, :destroy]
  before_action :group_organizer_only, only: [:update, :deny]
  before_action :group_owner_only, only: [:destroy]

  def update
    @member.update!(pending:false)
    redirect_to organizings_path, notice: 'グループ参加を許可しました'
  end

  def deny
    @member.destroy!
    redirect_to organizings_path, notice: 'グループ参加を却下しました'
  end

  def accept_all_members
    Member.where(group_id: current_user.organizing_groups.pluck(:id), pending:true).update_all(pending:false)
    redirect_to organizings_path, notice: 'グループ参加をすべて許可しました'
  end

  def destroy
    group = @member.group
    @member.destroy!
    redirect_to organizings_group_path(group.id), notice: 'メンバーを削除しました'
  end

  private

  def set_member
    @member = Member.find(params[:id])
  end

  def group_organizer_only
    if current_user.organizers.find_by(group_id:@member.group_id).blank?
      redirect_to "/", notice: "オーガナイザーのみアクセスできます"
    end
  end

  def group_owner_only
    unless current_user == @member.group.owner
      redirect_to "/", notice: "オーナーのみアクセスできます"
    end
  end

end
