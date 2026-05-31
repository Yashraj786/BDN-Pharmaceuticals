class CreateRawMaterials < ActiveRecord::Migration[7.2]
  def change
    create_table :raw_materials do |t|
      t.string :material_name
      t.string :unit_of_measurement
      t.decimal :current_stock_quantity
      t.decimal :reorder_level
      t.integer :supplier_id
      t.decimal :cost_per_unit
      t.datetime :last_updated_at

      t.timestamps
    end
  end
end
