class CreateTranslations < ActiveRecord::Migration[5.2]
  def change
    create_table :translations do |t|
      t.references :event, foreign_key: true
      t.text :content
      t.string :code

      t.timestamps
    end
  end
end
