class ParticipantsController < ApplicationController
  before_action :cannot_participate_past_event
  before_action :cannot_participate_full_event, only: [:create, :connection]

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
    event_id = participant.event_id
    if participant.user != current_user
      redirect_to events_path, notice: t('helpers.notice.user_only')
    else
      participant.destroy!
      redirect_to event_path(event_id), notice: t('helpers.notice.delete_participant_own')
    end
  end

  def connection
    participant_infomation = {user: {event_id: params[:event_id], event_language_id: params[:event_language_id], group_id: params[:group_id], guest: params[:guest]}}
    redirect_to new_user_registration_path(participant_infomation), notice: t('helpers.notice.signup_and_join')
  end

  private

  def participant_params
    params.permit(:event_id, :group_id, :event_language_id, :guest)
  end

  def cannot_participate_past_event
    event = Event.find(params[:event_id])
    redirect_to event_path(params[:event_id]), notice: t('helpers.notice.past_event') if event.schedule < Time.zone.now
  end

  def cannot_participate_full_event
    event_language = EventLanguage.find(params[:event_language_id])
    if event_language.max - event_language.participants.count == 0
      redirect_to event_path(params[:user][:event_id]), notice: t('helpers.notice.full_event')
    end
  end

end
