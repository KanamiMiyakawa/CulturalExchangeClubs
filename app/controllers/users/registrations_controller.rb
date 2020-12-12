class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  def new
    super
  end

  def create
    super
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

end
