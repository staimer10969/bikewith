class CreateNotices < ActiveRecord::Migration[6.1]
  def change
    create_table :notices do |t|
      t.integer :visitor_id, null: false
      t.integer :visited_id, null: false
      t.integer :comment_id
      t.integer :like_id
      t.string :action, default: '', null: false
      t.datetime :checked, default: false, null: false

      t.timestamps
    end

    add_index :notices, :visitor_id
    add_index :notices, :visited_id
    add_index :notices, :comment_id
    add_index :notices, :like_id
  end
end
