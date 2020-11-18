class Organizings::MembersController < ApplicationController
  before_action :set_member, only: [:update, :deny, :destroy]

  def update
    @member.update!(pending:false)
    redirect_to organizings_path, notice: 'グループ参加を許可しました'
  end

  def deny
    @member.destroy!
    redirect_to organizings_path, notice: 'グループ参加を却下しました'
  end

  def accept_all_members
    params[:ids].each do |id|
      Member.find(id.to_i).update!(pending:false)
    end
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
end
