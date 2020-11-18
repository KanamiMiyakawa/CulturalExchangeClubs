class Organizings::GroupsController < ApplicationController
  before_action :set_group, only: [:show, :giveowner]

  def show
    @owner = @group.owner
    @organizers = @group.organizers.where.not(user_id:@owner.id).includes(:user)
    @members = @group.members.where.not(user_id:@organizers.pluck(:user_id)).where.not(user_id:@owner.id).includes(:user)
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
