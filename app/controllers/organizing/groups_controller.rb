class Organizing::GroupsController < ApplicationController
  before_action :authenticate_user!

  before_action :set_group
  before_action :group_owner_only

  def show
    @owner = @group.owner
    @organizers = @group.organizers.where.not(user_id:@owner.id).includes(:user)
    @members = @group.members.where.not(user_id:@organizers.pluck(:user_id)).where.not(user_id:@owner.id).where(pending:false).includes(:user)
  end

  def edit
  end

  def update
    if @group.update(group_params)
      redirect_to organizing_path, notice: t('helpers.notice.update_group')
    else
      render :edit
    end
  end

  def destroy
    @group.destroy!
    redirect_to organizing_path, notice: t('helpers.notice.delete_group')
  end

  def give_owner
    if Organizer.find_by(group_id:@group.id, user_id:params[:user_id]).nil?
      @group.organizers.create!(user_id:params[:user_id])
    end
    @group.update!(owner_id:params[:user_id])
    redirect_to organizing_path, notice: t('helpers.notice.give_owner')
  end

  def create_organizer
    @group.organizers.create!(user_id:params[:user_id])
    redirect_to organizing_group_path(@group), notice: t('helpers.notice.create_organizer')
  end

  def delete_organizer
    Organizer.find(params[:organizer_id]).destroy!
    redirect_to organizing_group_path(@group), notice: t('helpers.notice.delete_organizer')
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:name, :detail, :permission)
  end

  def group_owner_only
    unless current_user == @group.owner
      redirect_to "/", notice: t('helpers.notice.group_owner_only')
    end
  end

end
