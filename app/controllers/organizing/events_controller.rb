class Organizing::EventsController < ApplicationController
  def new
    @event = Event.new
  end
end
