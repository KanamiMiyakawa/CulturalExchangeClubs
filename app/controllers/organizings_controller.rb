class OrganizingsController < ApplicationController
  before_action :authenticate_user!
  before_action :any_organizer

  def show
    @groups = current_user.organizing_groups
    @pending_members = Member.where(group_id: @groups.pluck(:id), pending:true)
    @events = current_user.organizing_events
    @pending_participants = Participant.where(event_id: @events.pluck(:id), pending: true)
  end

end
