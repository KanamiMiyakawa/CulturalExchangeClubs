class EventsController < ApplicationController

  def index
    if params[:q].present?
      # 検索している場合の分岐
      if params[:geo][:address].present? && params[:geo][:within].present? && params[:q][:online_eq] != "true"
        # リアルのみかリアルとオンライン両方 = ransack + geocoder
        @q = Event.ransack(params[:q])
        @address = params[:geo][:address]
        results = Geocoder.search(params[:geo][:address])
        latlng = results.first.coordinates
        @within = params[:geo][:within].to_i

        if params[:q][:online_eq] == "false"
          # リアルイベントのみ
          @events = @q.result(distinct: true).near(latlng, @within).where('schedule >= ?', Time.zone.now).order(schedule: "ASC").page(params[:page])
        else
          # リアルとオンライン両方
          @events1 = @q.result(distinct: true)
                    .near(latlng, @within)
                    .where('schedule >= ?', Time.zone.now)
          @events2 = @q.result(distinct: true)
                    .where(online: true)
                    .where('schedule >= ?', Time.zone.now)
          @events = @events1 + @events2
          @events.sort_by! {|a| a[:schedule]}
          @events = Kaminari.paginate_array(@events).page(params[:page])
        end
      else
        # オンラインのみ = ransackのみ
        @q = Event.ransack(params[:q])
        @events = @q.result(distinct: true).where('schedule >= ?', Time.zone.now).order(schedule: "ASC").page(params[:page])
      end
    else
      # 初回表示
      if user_signed_in? && current_user.address.present?
        # 住所から50キロ内＋オンライン
        @q = Event.ransack(params[:q])
        # 以下、互換性のないActiveRelationでor条件が使えなかった
        # @events = @q.result(distinct: true).near([current_user.lat, current_user.lon], 50)
        #           .or(@q.result(distinct: true).where(online: true))
        #           .where('schedule >= ?', Time.zone.now)
        #           .order(schedule: "ASC")
        #           .limit(20)
        @address = current_user.address
        @within = 50
        @events1 = Event.near([current_user.lat, current_user.lon], 50)
                  .where('schedule >= ?', Time.zone.now)
        @events2 = Event.where(online: true)
                  .where('schedule >= ?', Time.zone.now)
        @events = @events1 + @events2
        @events.sort_by! {|a| a[:schedule]}
        @events = Kaminari.paginate_array(@events).page(params[:page])
      else
        # 全件表示
        @q = Event.ransack(params[:q])
        @events = Event.where('schedule >= ?', Time.zone.now).order(schedule: "ASC").page(params[:page])
      end
    end

    @languages = Language.all.map { |lang| [lang.ja_name, lang.id]}
    @index_date = 0
    if user_signed_in?
      @user = current_user
      @coming_events = @user.events.where('schedule >= ?', Time.zone.now).order(schedule: "ASC").limit(3)
      @organizing_events = @user.organizing_events.where('schedule >= ?', Time.zone.now).order(schedule: "ASC").limit(3)
    end

    # googleMap用変数
    gon.real_events = @events.map do |event|
      next if event.online
      {name: event.name, schedule: "#{l event.schedule, format: :long}", address: event.address, lat: event.lat, lng: event.lon, id: event.id }
    end.compact

    # 住所検索したか？
    if params[:q].present? && params[:geo][:address].present? && params[:geo][:within].present? && params[:q][:online_eq] != "true"
      # geocode済み
      gon.home = {name: t('helpers.map.searched_address'), lat: latlng[0], lng: latlng[1]}
    elsif user_signed_in? && @user.address.present?
      gon.home = {name: t('helpers.map.your_address'), lat: @user.lat, lng: @user.lon }
    else
      # デフォルト：スカイツリー
      gon.home = {lat: 35.7100069, lng: 139.8108103}
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

    # googleMap用変数
    unless @event.online?
      gon.event = {name: @event.name, schedule: "#{l @event.schedule, format: :long}", address: @event.address, lat: @event.lat, lng: @event.lon}
    end
  end
end
