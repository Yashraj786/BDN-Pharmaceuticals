class CreateInventories < ActiveRecord::Migration[7.2]
  def change
    create_table :inventories do |t|
      t.string :product_name
      t.decimal :quantity_liters
      t.integer :quantity_bottles
      t.string :storage_location
      t.decimal :cost_per_liter
      t.decimal :sale_price_per_liter
      t.datetime :last_updated_at

      t.timestamps
    end
  end
end
