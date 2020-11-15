class CreateGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :groups do |t|
      t.string :name, null: false
      t.text :detail, default: ""
      t.boolean :permission, default: false, null: false

      t.timestamps
    end
  end
end
