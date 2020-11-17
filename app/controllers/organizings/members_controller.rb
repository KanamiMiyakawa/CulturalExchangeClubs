class Organizings::MembersController < ApplicationController
  def update
    Member.find(params[:id]).update!(pending:false)
    redirect_to organizings_path, notice: 'グループ参加を許可しました'
  end

  def destroy
    Member.find(params[:id]).destroy!
    redirect_to organizings_path, notice: 'グループ参加を却下しました'
  end
end
