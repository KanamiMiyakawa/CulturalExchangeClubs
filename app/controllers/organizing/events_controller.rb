class Organizing::EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group, only: [:new, :create, :edit, :update]
  before_action :set_organizers, only: [:new, :create, :edit, :update]
  before_action :set_event, only: [:edit, :update, :destroy]
  before_action :group_organizer_only

  def new
    @event = Event.new
    2.times { @event.event_languages.build }
    @languages = Language.all
  end

  def create
    @event = @group.events.build(event_params)
    if @event.save
      redirect_to event_path(@event), notice: 'イベントを作成しました！'
    else
      render :new
    end
  end

  def edit
    @languages = Language.all
  end

  def update
    if @event.update(event_params)
      redirect_to event_path(@event), notice: 'イベントを更新しました！'
    else
      render :edit
    end
  end

  def destroy
    @event.destroy!
    redirect_to organizing_path, notice: 'グループを削除しました'
  end

  private

  def set_group
    @group = Group.find(params[:group_id])
  end

  def set_event
    @event = Event.find(params[:id])
  end

  def set_organizers
    @organizers = @group.organizers
  end

  def group_organizer_only
    if Organizer.find_by(group_id:params[:group_id], user_id:current_user.id).blank?
      redirect_to organizing_path, notice: 'そのグループのオーガナイザーのみアクセスできます'
    end
  end

  def event_params
    params.require(:event).permit(:name, :schedule, :content, :online, :permission, :guest_allowed, :address, :place, :organizer_id,
        event_languages_attributes: [:id, :event_id, :language_id, :max])
  end
end
