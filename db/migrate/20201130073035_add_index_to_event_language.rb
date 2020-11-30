class AddIndexToEventLanguage < ActiveRecord::Migration[5.2]
  def change
    add_index :event_languages, [:event_id, :language_id], unique: true
  end
end
