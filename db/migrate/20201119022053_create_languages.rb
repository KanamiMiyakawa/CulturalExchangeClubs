class CreateLanguages < ActiveRecord::Migration[5.2]
  def change
    create_table :languages do |t|
      t.string :code
      t.string :en_name
      t.string :ja_name

      t.timestamps
    end
  end
end
