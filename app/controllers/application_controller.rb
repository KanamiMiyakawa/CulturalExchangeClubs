class ApplicationController < ActionController::Base

  def any_organizer
    redirect_to "/", notice: "オーガナイザーのみアクセスできます" unless current_user.organizers.present?
  end

end
