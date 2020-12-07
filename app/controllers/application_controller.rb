class ApplicationController < ActionController::Base

  def any_organizer
    redirect_to "/", notice: t('helpers.notice.any_organizer') unless current_user.organizers.present?
  end

end
