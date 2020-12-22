class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:profile]

  def top
    @q = Event.ransack(params[:q])
    @events = Event.where('schedule >= ?', Time.zone.now).order(schedule: "ASC").limit(5)
    @languages = Language.all.map { |lang| [lang.ja_name, lang.id]}
    @index_date = 0
  end

  #開発時の暫定トップ
  def devtop
    project_id = ENV['CLOUD_PROJECT_ID']
    client = Google::Cloud::Translate.new version: :v2, project_id: project_id
    @text = "おいしいコーヒーはお好きですか？\nお洒落なカフェでみんなでおしゃべりしましょう!"
    target = "ja"
    begin
      @translation = client.translate @text, to: "cu"
    rescue
      @translation = "翻訳未対応"
    end
    binding.pry
  end

  def profile
    @user = User.find(params[:id])
    if @user == current_user
      @groups = @user.groups
      @events = @user.events.where('schedule >= ?', Time.zone.now).order(schedule: "ASC").limit(3)
      @organizing_events = @user.organizing_events.where('schedule >= ?', Time.zone.now).order(schedule: "ASC").limit(3)
      @index_date = 0

      # リアルのイベントのみ抜き出し、データ加工
      map_data_1 = @events.map do |event|
        next if event.online
        {name: event.name, schedule: "#{l event.schedule, format: :long}", address: event.address, lat: event.lat, lng: event.lon}
      end.compact
      map_data_2 = @organizing_events.map do |event|
        next if event.online
        {name: event.name, schedule: "#{l event.schedule, format: :long}", address: event.address, lat: event.lat, lng: event.lon}
      end.compact

      # googleMap用の変数に引き渡し
      gon.real_events = map_data_1.concat(map_data_2)
      if @user.address.present?
        gon.home = {name: t('helpers.map.your_address'), lat: @user.lat, lng: @user.lon }
      else
        # デフォルト：スカイツリー
        gon.home = {name: t('helpers.map.need_address'), lat: 35.7100069, lng: 139.8108103}
      end
    end
  end

  def change_map_data(events)
    events.map do |event|
      next if event.online?
      {name: event.name, schedule: "#{l event.schedule, format: :long}", address: event.address, lat: event.lat, lng: event.lon}
    end
  end
end
