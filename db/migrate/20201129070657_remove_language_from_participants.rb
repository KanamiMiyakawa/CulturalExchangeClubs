class RemoveLanguageFromParticipants < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key :participants, :languages
    remove_index :participants, :language_id
    remove_column :participants, :language_id, :bigint
  end
end
