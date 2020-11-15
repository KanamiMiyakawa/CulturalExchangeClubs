class GroupsController < ApplicationController
  before_action :set_group, only: [:show]

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      redirect_to @group, notice: 'グループを作成しました！'
    else
      render :new
    end
  end

  def show
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:name, :detail, :permission)
  end
end
