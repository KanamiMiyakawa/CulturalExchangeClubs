class Organizing::EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_languages, only: [:new, :create, :edit, :update]
  before_action :set_group, only: [:new, :create, :edit, :update, :translation, :create_translation, :edit_translation, :update_translation]
  before_action :set_organizers, only: [:new, :create, :edit, :update]
  before_action :set_event, only: [:edit, :update, :destroy, :purge_image, :translation, :create_translation, :edit_translation, :update_translation]
  before_action :group_organizer_only

  def new
    @event = Event.new
    2.times { @event.event_languages.build }
    gon.event = { lat: 35.7100069, lng: 139.8108103 }
  end

  def create
    @event = @group.events.build(event_params)
    if @event.save
      if params[:event][:translate] == "1"
        redirect_to translation_organizing_group_event_path(group_id: @group.id, id: @event.id), notice: t('helpers.notice.create_event')
      else
        redirect_to event_path(@event), notice: t('helpers.notice.create_event')
      end
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
      if params[:event][:translate] == "1"
        redirect_to edit_translation_organizing_group_event_path(group_id: @group.id, id: @event.id), notice: t('helpers.notice.update_event')
      else
        redirect_to event_path(@event), notice: t('helpers.notice.update_event')
      end
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

  def translation
    project_id = ENV['CLOUD_PROJECT_ID']
    client = Google::Cloud::Translate.new version: :v2, project_id: project_id

    # 入力元のcontentの変数化
    @original_content = @event.content
    @original_language = (client.detect @original_content).language

    # 翻訳後の変数化
    @translation = {}
    @event.event_languages.each do |lang|
      target = lang.language.code
      next if target == @original_language
      begin
        result = client.translate @original_content, to: target
        @translation.store(target, CGI.unescapeHTML(result.text))
      rescue
        result = nil
        @translation.store(target, result)
      end
    end
  end

  def create_translation
    n = 0
    count = params[:translation_count].to_i
    if @event.update(content: params[:original_content])

      while n <= count do
        s = "translation_#{n}".intern
        n += 1
        next if params[s][:content].blank?
        @event.translations.create!(content: params[s][:content], code: params[s][:code])
      end
      redirect_to event_path(@event), notice: t('helpers.notice.created_translation')

    else
      # リダイレクト処理
      @original_content = params[:original_content]
      @original_language = params[:original_language]
      @translation = {}
      while n <= count do
        s = "translation_#{n}".intern
        n += 1
        @translation.store(params[s][:code], params[s][:content])
      end
      render :translation
    end
  end

  # translationとほぼ同じなので統一できる
  def edit_translation
    project_id = ENV['CLOUD_PROJECT_ID']
    client = Google::Cloud::Translate.new version: :v2, project_id: project_id

    # 入力元のcontentの変数化
    @original_content = @event.content
    @original_language = (client.detect @original_content).language

    # 翻訳後の変数化
    @translation = {}
    @event.event_languages.each do |lang|
      target = lang.language.code
      next if target == @original_language

      # すでに翻訳があるか確認
      old_translation = Translation.find_by(event_id: @event.id, code: target)

      begin
        result = client.translate @original_content, to: target
        @translation.store(target, CGI.unescapeHTML(result.text))
      rescue
        if old_translation.present?
          result = old_translation.content
        else
          result = nil
        end
        @translation.store(target, result)
      end
    end
  end

  # create_translationとほぼ同じなので統一できる
  def update_translation
    n = 0
    count = params[:translation_count].to_i
    if @event.update(content: params[:original_content])

      while n <= count do
        s = "translation_#{n}".intern
        n += 1

        # すでに翻訳がある
        if @event.translations.pluck(:code).include?(params[s][:code])
          old_translation = Translation.find_by(event_id: @event.id, code: params[s][:code])
          if params[s][:content].blank?
            old_translation.destroy!
          else
            old_translation.update!(content: params[s][:content])
          end
        else
        # 未翻訳
          next if params[s][:content].blank?
          @event.translations.create!(content: params[s][:content], code: params[s][:code])
        end
      end
      redirect_to event_path(@event), notice: t('helpers.notice.updated_translation')

    else
      # リダイレクト処理
      @original_content = params[:original_content]
      @original_language = params[:original_language]
      @translation = {}
      while n <= count do
        s = "translation_#{n}".intern
        n += 1
        @translation.store(params[s][:code], params[s][:content])
      end
      render :edit_translation
    end
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
