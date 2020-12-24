class Users::SessionsController < Devise::SessionsController

  def new
    super
  end

  def create
    super
  end

  def destroy
    super
  end

  def new_guest
    if params[:role] == "owner"
      id_range = 1..5
      role = t('helpers.status.owner')
    elsif params[:role] == "organizer"
      id_range = 6..10
      role = t('helpers.status.organizer')
    else
      id_range = 11..30
      role = t('helpers.status.member')
    end
    user = User.find(rand(id_range))
    sign_in user
    redirect_to events_path, notice: t('helpers.notice.guest_login', {role: role})
  end

  protected

  def after_sign_in_path_for(resource)
    "/events"
  end
end
