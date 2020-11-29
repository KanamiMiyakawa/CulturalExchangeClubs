class ParticipantsController < ApplicationController
  def create
    group = Group.find(params[:group_id])
    if params[:guest] == "false" && !group.users.include?(current_user)
      @participant = current_user.participants.build(participant_params)
      if @participant.save
        current_user.members.create!(group_id:group.id)
        redirect_to event_path(params[:event_id]), notice: "イベントとグループに参加リクエストを送りました！\n現在のステータスをご確認ください"
      else
        redirect_to event_path(params[:event_id]), notice: "参加リクエストが送れませんでした"
      end
    else
      @participant = current_user.participants.build(participant_params)
      if @participant.save
        redirect_to event_path(params[:event_id]), notice: "イベントに参加リクエストを送りました！\n現在のステータスをご確認ください"
      else
        redirect_to event_path(params[:event_id]), notice: "参加リクエストが送れませんでした"
      end
    end
  end

  def destroy
    participant = Participant.find(params[:id])
    if participant.user != current_user
      redirect_to events_path, notice: "当該ユーザのみ情報を編集できます"
    else
      participant.destroy!
      redirect_to "/profile/#{current_user.id}", notice: "イベント参加を削除しました"
    end
  end

  private

  def participant_params
    params.permit(:event_id, :group_id, :event_language_id, :guest)
  end
end
