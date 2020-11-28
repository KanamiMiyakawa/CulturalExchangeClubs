class OrganizingsController < ApplicationController
  before_action :authenticate_user!
  before_action :any_organizer, only: [:show]
  before_action :group_organizer_only, only: [:create]
  before_action :group_owner_only, only: [:destroy]

  def show
    @groups = current_user.organizing_groups
    @pending_members = Member.where(group_id: @groups.pluck(:id), pending:true)
    @events = current_user.organizing_events
    @pending_participants = Participant.where(event_id: @events.pluck(:id), pending: true)
  end

  def create
    group = Group.find(params[:group_id])
    group.organizers.create!(user_id:params[:user_id])
    redirect_to organizing_group_path(group.id), notice: 'オーガナイザー権限を付与しました'
  end

  def destroy
    Organizer.find(params[:id]).destroy!
    redirect_to organizing_group_path(params[:group_id]), notice: 'オーガナイザー権限を削除しました'
  end

  private

  def group_organizer_only
    if current_user.organizers.find_by(group_id:params[:group_id]).blank?
      redirect_to "/", notice: "オーガナイザーのみアクセスできます"
    end
  end

  def group_owner_only
    unless current_user == Organizer.find(params[:id]).group.owner
      redirect_to "/", notice: "オーナーのみアクセスできます"
    end
  end

end
