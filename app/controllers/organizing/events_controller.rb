class Organizing::EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_organizer
  before_action :event_params, only: [:create]

  def new
    @event = Event.new
  end

  def create
    @event = @organizer.events.build(event_params)
    if @event.save
      redirect_to event_path(@event), notice: 'イベントを作成しました！'
    else
      render :new
    end
  end

  private

  def set_group
    @group = Group.find(params[:group_id])
  end

  def set_organizer
    @organizer = Organizer.find_by(user_id:current_user.id, group_id:params[:group_id])
  end

  def group_organizer_only
    if @organizer.nil?
      #リダイレクト処理
    end
  end

  def event_params
    params.require(:event).permit(:name, :schedule, :content, :online, :premission, :guest_allowed, :address, :place).merge(group_id: params[:group_id])
  end
end
