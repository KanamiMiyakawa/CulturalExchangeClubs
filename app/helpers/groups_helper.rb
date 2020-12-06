module GroupsHelper

  def group_new_or_edit
    if action_name == 'new' || action_name == 'create'
      groups_path
    elsif action_name == 'edit' || action_name == 'update'
      organizing_group_path
    end
  end

  def group_submit_btn
    if action_name == 'new' || action_name == 'create'
      t('helpers.btn.create_group')
    elsif action_name == "edit" || action_name == 'update'
      t('helpers.btn.edit_group')
    end
  end

end
