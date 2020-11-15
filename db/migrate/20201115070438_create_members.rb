class CreateMembers < ActiveRecord::Migration[5.2]
  def change
    create_table :members do |t|
      t.references :user, foreign_key: true
      t.references :group, foreign_key: true
      t.boolean :organizer, default: false, null: false
      t.boolean :main, default: false, null: false
      t.boolean :pending, default: false, null: false

      t.timestamps
    end
  end
end
