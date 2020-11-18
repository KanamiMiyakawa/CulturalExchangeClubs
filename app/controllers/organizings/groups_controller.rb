class Organizings::GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy, :giveowner]

  def show
    @owner = @group.owner
    @organizers = @group.organizers.where.not(user_id:@owner.id).includes(:user)
    @members = @group.members.where.not(user_id:@organizers.pluck(:user_id)).where.not(user_id:@owner.id).where(pending:false).includes(:user)
  end

  def edit
  end

  def update
    if @group.update(group_params)
      redirect_to organizings_path, notice: 'グループを更新しました'
    else
      render :edit
    end
  end

  def destroy
    @group.destroy!
    redirect_to organizings_path, notice: 'グループを削除しました'
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

  def group_params
    params.require(:group).permit(:name, :detail, :permission)
  end
end
