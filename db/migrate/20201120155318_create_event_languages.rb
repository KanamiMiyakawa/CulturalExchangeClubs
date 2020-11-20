class CreateEventLanguages < ActiveRecord::Migration[5.2]
  def change
    create_table :event_languages do |t|
      t.references :event, foreign_key: true
      t.references :language, foreign_key: true
      t.integer :max

      t.timestamps
    end
  end
end
