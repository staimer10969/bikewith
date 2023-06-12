class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.integer :genre_id, null: false
      t.string :brand, null: false
      t.string :model, null: false
      t.integer :model_year, null: false
      t.integer :engine, null: false
      t.integer :price, null: false

      t.timestamps
    end
  end
end
