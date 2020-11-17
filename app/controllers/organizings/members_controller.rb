class Organizings::MembersController < ApplicationController
  def update
    Member.find(params[:id]).update!(pending:false)
    redirect_to organizings_path, notice: 'グループ参加を許可しました'
  end
end
