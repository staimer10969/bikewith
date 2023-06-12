class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.integer :customer_id, null: false
      t.integer :review_id, null: false
      t.string :review_comment, null: false

      t.timestamps
    end
  end
end
