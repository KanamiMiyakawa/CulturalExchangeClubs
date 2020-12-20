class Organizing::EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_languages, only: [:new, :create, :edit, :update]
  before_action :set_group, only: [:new, :create, :edit, :update]
  before_action :set_organizers, only: [:new, :create, :edit, :update]
  before_action :set_event, only: [:edit, :update, :destroy, :purge_image]
  before_action :group_organizer_only

  def new
    @event = Event.new
    2.times { @event.event_languages.build }
    gon.event = { lat: 35.7100069, lng: 139.8108103 }
  end

  def create
    @event = @group.events.build(event_params)
    binding.pry
    if @event.save
      redirect_to event_path(@event), notice: t('helpers.notice.create_event')
    else
      if @event.lat.present? && @event.lon.present?
        gon.event = { lat: @event.lat, lng: @event.lon, input: true}
      else
        gon.event = { lat: 35.7100069, lng: 139.8108103 }
      end
      render :new
    end
  end

  def edit
    if @event.lat.present? && @event.lon.present?
      gon.event = { lat: @event.lat, lng: @event.lon, input: true}
    else
      gon.event = { lat: 35.7100069, lng: 139.8108103 }
    end
  end

  def update
    if @event.update(event_params)
      redirect_to event_path(@event), notice: t('helpers.notice.update_event')
    else
      if @event.lat.present? && @event.lon.present?
        gon.event = { lat: @event.lat, lng: @event.lon, input: true}
      else
        gon.event = { lat: 35.7100069, lng: 139.8108103 }
      end
      render :edit
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

  def purge_image
    image = @event.images.find(params[:image_id])
    image.purge
    redirect_to edit_organizing_group_event_path(group_id: params[:group_id], id: @event.id), notice: t('helpers.notice.purge_image')
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
        event_languages_attributes: [:id, :event_id, :language_id, :max], images: [])
  end
end
