class AddOrganizerToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :organizer, :boolean, default: false, null: false
  end
end
