class AddReferencesToParticipants < ActiveRecord::Migration[5.2]
  def change
    add_reference :participants, :group, foreign_key: true
  end
end
