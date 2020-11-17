class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy]

  def index
    @groups = Group.all
  end

  def new
    @group = Group.new
  end

  def create
    @group = current_user.own_groups.build(group_params)
    if @group.save
      current_user.members.create!(group_id:@group.id)
      current_user.organizers.create!(group_id:@group.id)
      redirect_to @group, notice: 'グループを作成しました！'
    else
      render :new
    end
  end

  def show
    @members = @group.members.includes(:user)
  end

  def edit
  end

  def update
    if @group.update(group_params)
      redirect_to @group, notice: 'グループを更新しました'
    else
      render :edit
    end
  end

  def destroy
    @group.destroy
    redirect_to "/", notice: 'グループを削除しました'
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:name, :detail, :permission)
  end
end
