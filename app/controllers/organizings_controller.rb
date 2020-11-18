class OrganizingsController < ApplicationController
  def show
    @groups = current_user.organizing_groups
    @pending_members = Member.where(group_id: @groups.pluck(:id), pending:true)
  end

  def create
    group = Group.find(params[:group_id])
    group.organizers.create!(user_id:params[:user_id])
    redirect_to organizings_group_path(group.id), notice: 'オーガナイザー権限を付与しました'
  end

  def destroy
    organizer = Organizer.find(params[:id])
    group = organizer.group
    organizer.destroy!
    redirect_to organizings_group_path(group.id), notice: 'オーガナイザー権限を削除しました'
  end
end
