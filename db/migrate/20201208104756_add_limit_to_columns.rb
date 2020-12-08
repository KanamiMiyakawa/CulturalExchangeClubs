class AddLimitToColumns < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :name, :string, limit: 255
    change_column :users, :email, :string, limit: 255
    change_column :users, :introduction, :text, limit: 400
    change_column :users, :address, :string, limit: 255

    change_column :groups, :name, :string, limit: 255
    change_column :groups, :detail, :string, limit: 800

    change_column :events, :name, :string, limit: 255
    change_column :events, :content, :string, limit: 800
    change_column :events, :address, :string, limit: 255
  end
end
