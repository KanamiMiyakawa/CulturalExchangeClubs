class EventsController < ApplicationController

  def index
    if params[:commit] == "検索する！"
      # 検索している場合の分岐
      if params[:geo][:address].present? && params[:geo][:within].present? && params[:q][:online_eq] != "true"
        # ransack + geocoder
        @q = Event.ransack(params[:q])
        @address = params[:geo][:address]
        results = Geocoder.search(params[:geo][:address])
        latlng = results.first.coordinates
        @within = params[:geo][:within].to_i
        @events = @q.result(distinct: true).near(latlng, @within).where('schedule >= ?', Time.zone.now).order(schedule: "ASC")
      else
        # ransackのみ
        @q = Event.ransack(params[:q])
        @events = @q.result(distinct: true).where('schedule >= ?', Time.zone.now).order(schedule: "ASC").limit(20)
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
      else
        # 全件表示
        @q = Event.ransack(params[:q])
        @events = Event.where('schedule >= ?', Time.zone.now).order(schedule: "ASC")
      end
    end

    @languages = Language.all.map { |lang| [lang.ja_name, lang.id]}
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

    # googleMap用変数
    unless @event.online?
      gon.event = {name: @event.name, schedule: "#{l @event.schedule, format: :long}", address: @event.address, lat: @event.lat, lng: @event.lon}
    end
  end
end
