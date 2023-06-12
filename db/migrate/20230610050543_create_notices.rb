class CreateNotices < ActiveRecord::Migration[6.1]
  def change
    create_table :notices do |t|
      t.integer :comment_id, null: false
      t.integer :like_id, null: false
      t.string :notice_content, null: false
      t.datetime :notice_at, null: false

      t.timestamps
    end
  end
end
