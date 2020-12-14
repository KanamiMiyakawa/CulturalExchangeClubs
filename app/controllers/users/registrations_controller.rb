class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  def new
    super
  end

  def create
    build_resource(sign_up_params)

    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)

        # participant も同時に作成する場合
        if params[:user].present? && params[:user][:event_id].present? && params[:user][:event_language_id].present? && params[:user][:group_id].present? && params[:user][:guest].present?

          cannot_participate_past_event
          cannot_participate_full_event

          group = Group.find(params[:user][:group_id])
          participant_params = {event_id: params[:user][:event_id], event_language_id: params[:user][:event_language_id], group_id: params[:user][:group_id], guest: params[:user][:guest]}
          if params[:user][:guest] == "false" && !group.users.include?(current_user)
            @participant = current_user.participants.build(participant_params)
            if @participant.save
              current_user.members.create!(group_id:group.id)
              redirect_to event_path(params[:user][:event_id]), notice: t('helpers.notice.send_group_and_event_request')
            else
              redirect_to event_path(params[:user][:event_id]), notice: t('helpers.notice.cannot_send_request')
            end
          else
            @participant = current_user.participants.build(participant_params)
            if @participant.save
              redirect_to event_path(params[:user][:event_id]), notice: t('helpers.notice.send_event_request')
            else
              redirect_to event_path(params[:user][:event_id]), notice: t('helpers.notice.cannot_send_request')
            end
          end
        else
          respond_with resource, location: after_sign_up_path_for(resource)
        end

      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  def edit
    super
  end

  def update
    super
    if account_update_params[:avatar].present?
      resource.avatar.attach(account_update_params[:avatar])
    end
  end

  def destroy
    super
  end

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :introduction, :address, :avatar])
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :introduction, :address, :avatar])
  end

  def after_sign_up_path_for(resource)
    "/events"
  end

  def after_update_path_for(resource)
    "/profile/#{current_user.id}"
  end

  def cannot_participate_past_event
    event = Event.find(params[:user][:event_id])
    redirect_to event_path(params[:user][:event_id]), notice: t('helpers.notice.past_event') if event.schedule < Time.zone.now
  end

  def cannot_participate_full_event
    event_language = EventLanguage.find(params[:user][:event_language_id])
    if event_language.max - event_language.participants.count == 0
      redirect_to event_path(params[:user][:event_id]), notice: t('helpers.notice.full_event')
    end
  end

end
