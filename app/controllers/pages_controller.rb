class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:profile]

  #開発時の暫定トップ
  def devtop
  end

  def profile
    @user = User.find(params[:id])
    @members = @user.members.includes(:group) if @user == current_user
  end
end
