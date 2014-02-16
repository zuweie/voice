class CreateNovels < ActiveRecord::Migration
  def change
    create_table :novels do |t|
      t.string :name
      t.string :url
      t.string :poster
      t.string :author
      t.text :body
      t.datetime :updated
      t.integer :status
      t.string :keyword
      t.string :category
      t.references :speaker

      t.timestamps
    end
    add_index :novels, :speaker_id
  end
end
