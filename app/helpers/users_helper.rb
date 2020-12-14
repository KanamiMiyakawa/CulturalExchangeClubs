module UsersHelper

  def connection_participants_or_not
    if params[:user].present? && params[:user][:event_id].present? && params[:user][:event_language_id].present? && params[:user][:group_id].present? && params[:user][:guest].present?
      t('helpers.submit.signup_and_join')
    else
      t('.sign_up')
    end
  end
end
