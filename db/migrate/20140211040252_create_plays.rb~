class CreatePlays < ActiveRecord::Migration
  def change
    create_table :plays do |t|
      t.string :name
      t.string :url
      t.string :poster
      t.text   :body
      t.datetime :updated
      t.string :tag
      t.references :speaker

      t.timestamps
    end
    add_index :plays, :speaker_id
  end
end
