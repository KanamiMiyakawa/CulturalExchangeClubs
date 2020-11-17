class Organizings::GroupsController < ApplicationController
  before_action :set_group, only: [:show, :addorg, :delorg, :giveowner]

  def show
    @owner = @group.owner
    @organizers = @group.organized_users.where.not(id:@owner.id)
    @members = @group.users.where.not(id:@organizers.pluck(:id)).where.not(id:@owner.id)
  end

  def addorg
    @group.organizers.create!(user_id:params[:user_id])
    redirect_to organizings_group_path(@group), notice: 'オーガナイザー権限を付与しました'
  end

  def delorg
    Organizer.find_by(group_id:@group.id, user_id:params[:user_id]).destroy!
    redirect_to organizings_group_path(@group), notice: 'オーガナイザー権限を削除しました'
  end

  def giveowner
    if Organizer.find_by(group_id:@group.id, user_id:params[:user_id]).nil?
      @group.organizers.create!(user_id:params[:user_id])
    end
    @group.update!(owner_id:params[:user_id])
    redirect_to organizings_group_path(@group), notice: 'オーナーを変更しました'
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end
end
