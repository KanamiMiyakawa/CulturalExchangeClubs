class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group, only: [:show, :old_events]

  #開発中の暫定
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
    if @members.pluck(:user_id).include?(current_user.id)
      @member_self = Member.find_by(user_id:current_user.id, group_id:@group.id)
    end
    @pending_users = @members.where(pending:true)
    @organizers = @group.organized_users
    @events = @group.events.where('schedule >= ?', Time.zone.now).order(schedule: "ASC").limit(3)
    @index_date = 0
  end

  def old_events
    @events = @group.events.where('schedule < ?', Time.zone.now).order(schedule: "DESC")
    @index_date = 0
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:name, :detail, :permission)
  end
end
