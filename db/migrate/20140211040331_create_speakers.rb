class CreateSpeakers < ActiveRecord::Migration
  def change
    create_table :speakers do |t|
      t.string :name
      t.string :nameid
      t.string :qq
      t.string :email
      t.string :weixin
      t.string :weibo

      t.timestamps
    end
  end
end
