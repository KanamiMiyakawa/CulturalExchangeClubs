module EventsHelper

  def event_create_or_update
    if action_name == 'new' || action_name == 'create'
      organizing_group_events_path
    elsif action_name == 'edit' || action_name == 'update'
      organizing_group_event_path
    end
  end

end
