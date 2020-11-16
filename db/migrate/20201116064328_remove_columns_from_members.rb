class RemoveColumnsFromMembers < ActiveRecord::Migration[5.2]
  def change
    remove_column :members, :organizer, :boolean
    remove_column :members, :main, :boolean
  end
end
