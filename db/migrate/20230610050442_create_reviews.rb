class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.integer :customer_id, null: false
      t.integer :item_id, null: false
      t.string :comment
      t.integer :score
      t.string :address
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
