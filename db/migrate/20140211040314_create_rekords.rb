class CreateRekords < ActiveRecord::Migration
  def change
    create_table :rekords do |t|
      t.string :name
      t.string :url
      t.datetime :updated
      t.references :novel
      t.references :speaker

      t.timestamps
    end
    add_index :rekords, :novel_id
    add_index :rekords, :speaker_id
  end
end
