class ChangeColumnsToText < ActiveRecord::Migration[5.2]
  def up
    change_column :events, :content, :text
    change_column :groups, :detail, :text
  end

  def down
    change_column :events, :content, :string, limit: 800
    change_column :groups, :detail, :string, limit: 800
  end
end
