class PagesController < ApplicationController
  def devtop
  end
  def profile
    @user = User.find(params[:id])
  end
end
