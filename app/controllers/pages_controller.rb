class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:profile]

  #開発時の暫定トップ
  def devtop
  end

  def profile
    @user = User.find(params[:id])
    if @user == current_user
      @groups = @user.groups
      @events = @user.events.where('schedule >= ?', Time.zone.now).order(schedule: "ASC")
      @organizing_events = @user.organizing_events.where('schedule >= ?', Time.zone.now).order(schedule: "ASC")
      @index_date = 0
    end
  end
end
