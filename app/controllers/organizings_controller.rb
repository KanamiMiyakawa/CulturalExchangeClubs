class OrganizingsController < ApplicationController
  def index
    @groups = current_user.organizing_groups
    @pending_members = Member.where(group_id: @groups.pluck(:id), pending:true)
  end

  def permit
    Member.find(params[:id]).update!(pending:false)
    redirect_to organizings_path, notice: 'グループ参加を許可しました'
  end
end
