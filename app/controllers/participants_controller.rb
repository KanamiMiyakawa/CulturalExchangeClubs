class ParticipantsController < ApplicationController
  def create
    group = Group.find(params[:group_id])
    if params[:guest] == "false" && !group.users.include?(current_user)
      @participant = current_user.participants.build(participant_params)
      if @participant.save
        current_user.members.create!(group_id:group.id)
        redirect_to event_path(params[:event_id]), notice: t('helpers.notice.send_group_and_event_request')
      else
        redirect_to event_path(params[:event_id]), notice: t('helpers.notice.cannot_send_request')
      end
    else
      @participant = current_user.participants.build(participant_params)
      if @participant.save
        redirect_to event_path(params[:event_id]), notice: t('helpers.notice.send_event_request')
      else
        redirect_to event_path(params[:event_id]), notice: t('helpers.notice.cannot_send_request')
      end
    end
  end

  def destroy
    participant = Participant.find(params[:id])
    if participant.user != current_user
      redirect_to events_path, notice: t('helpers.notice.user_only')
    else
      participant.destroy!
      redirect_to "/profile/#{current_user.id}", notice: t('helpers.notice.delete_participant_own')
    end
  end

  private

  def participant_params
    params.permit(:event_id, :group_id, :event_language_id, :guest)
  end
end
