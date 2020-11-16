class OrganizingsController < ApplicationController
  def index
    @groups = current_user.organizing_groups
  end
end
