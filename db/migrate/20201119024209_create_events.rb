class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :name, null: false
      t.datetime :schedule, null: false
      t.references :organizer, foreign_key: true
      t.references :group, foreign_key: true
      t.text :content, null: false
      t.boolean :online, default: false
      t.boolean :permission, default: false
      t.boolean :guest_allowed, default: false
      t.string :address, default: ""
      t.float :lat
      t.float :lon
      t.string :place, default: ""

      t.timestamps
    end

    add_index :events, :name
    add_index :events, :schedule
    add_index :events, :content
  end
end
