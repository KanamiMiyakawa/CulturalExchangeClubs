class EventsController < ApplicationController
  def show
    @event = Event.find(params[:id])
    @group = @event.group
    @organizer = @event.organizer.user
    @organizers = @group.organized_users
  end
end
