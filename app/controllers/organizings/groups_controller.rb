class Organizings::GroupsController < ApplicationController
  before_action :set_group, only: [:show, :addorg]

  def show
    @owner = @group.owner
    @organizers = @group.organized_users.where.not(id:@owner.id)
    @members = @group.users.where.not(id:@organizers.pluck(:id)).where.not(id:@owner.id)
  end

  def addorg
    user = User.find(params[:user_id])
    user.organizers.create!(group_id:@group.id)
    redirect_to organizings_group_path(@group), notice: 'オーガナイザー権限を付与しました'
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end
end
