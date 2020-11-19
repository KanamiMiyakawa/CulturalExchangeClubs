class EventsController < ApplicationController

  def index
    @events = Event.where('schedule >= ?', Time.zone.now).order(schedule: "ASC")
  end

  def show
    @event = Event.find(params[:id])
    @group = @event.group
    @organizer = @event.organizer.user
    @organizers = @group.organized_users
  end
end
