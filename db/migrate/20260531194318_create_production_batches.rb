class CreateProductionBatches < ActiveRecord::Migration[7.2]
  def change
    create_table :production_batches do |t|
      t.string :batch_name
      t.date :batch_date
      t.string :product_name
      t.decimal :quantity_produced_liters
      t.decimal :production_cost
      t.decimal :expected_sale_price
      t.string :batch_status
      t.jsonb :raw_materials_used
      t.date :completed_date

      t.timestamps
    end
  end
end
