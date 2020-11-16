class RemoveOrganizerFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :organizer, :boolean
  end
end
