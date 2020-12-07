class EventsController < ApplicationController

  def index
    @q = Event.ransack(params[:q])
    @languages = Language.all
    @events = @q.result(distinct: true).where('schedule >= ?', Time.zone.now).order(schedule: "ASC").limit(20)
    # @events = Event.where('schedule >= ?', Time.zone.now).order(schedule: "ASC").limit(20)
    @index_date = 0
    if user_signed_in?
      @user = current_user
      @coming_events = @user.events.where('schedule >= ?', Time.zone.now).order(schedule: "ASC").limit(3)
      @organizing_events = @user.organizing_events.where('schedule >= ?', Time.zone.now).order(schedule: "ASC").limit(3)
    end
  end

  def show
    @event = Event.find(params[:id])
    @group = @event.group
    @organizer = @event.user
    @organizers = @group.organized_users
    @members = @group.members.includes(:user)
    @pending_users = @members.where(pending:true)
    @event_languages = @event.event_languages
  end
end
