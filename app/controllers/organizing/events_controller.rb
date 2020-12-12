class Organizing::EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_languages, only: [:new, :create, :edit, :update]
  before_action :set_group, only: [:new, :create, :edit, :update]
  before_action :set_organizers, only: [:new, :create, :edit, :update]
  before_action :set_event, only: [:edit, :update, :destroy]
  before_action :group_organizer_only

  def new
    @event = Event.new
    2.times { @event.event_languages.build }
    gon.event = nil
  end

  def create
    @event = @group.events.build(event_params)
    if @event.save
      redirect_to event_path(@event), notice: t('helpers.notice.create_event')
    else
      render :new
      if @event.online?
        gon.event = nil
      else
        gon.event = { lat: @event.lat, lng: @event.lon}
      end
    end
  end

  def edit
    if @event.online?
      gon.event = nil
    else
      gon.event = { lat: @event.lat, lng: @event.lon}
    end
  end

  def update
    if @event.update(event_params)
      redirect_to event_path(@event), notice: t('helpers.notice.update_event')
    else
      render :edit
      if @event.online?
        gon.event = nil
      else
        gon.event = { lat: @event.lat, lng: @event.lon}
      end
    end
  end

  def destroy
    @event.destroy!
    redirect_to organizing_path, notice: t('helpers.notice.delete_event')
  end

  def delete_language
    event_language = EventLanguage.find(params[:lang_id])
    event = event_language.event
    event_language.destroy!
    redirect_to event_path(event), notice: t('helpers.notice.delete_language')
  end

  private

  def set_languages
    @languages = Language.all
  end

  def set_group
    @group = Group.find(params[:group_id])
  end

  def set_organizers
    @organizers = @group.organizers
  end

  def set_event
    @event = Event.find(params[:id])
  end

  def group_organizer_only
    if Organizer.find_by(group_id:params[:group_id], user_id:current_user.id).blank?
      redirect_to organizing_path, notice: t('helpers.notice.group_organizer_only')
    end
  end

  def event_params
    params.require(:event).permit(:name, :schedule, :content, :online, :permission, :guest_allowed, :address, :place, :thumbnail, :organizer_id,
        event_languages_attributes: [:id, :event_id, :language_id, :max])
  end
end
