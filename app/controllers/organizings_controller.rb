class OrganizingsController < ApplicationController
  def show
    @groups = current_user.organizing_groups
    @pending_members = Member.where(group_id: @groups.pluck(:id), pending:true)
  end
end
