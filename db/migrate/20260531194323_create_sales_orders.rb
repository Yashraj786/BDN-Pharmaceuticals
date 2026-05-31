class CreateSalesOrders < ActiveRecord::Migration[7.2]
  def change
    create_table :sales_orders do |t|
      t.integer :customer_id
      t.string :customer_name
      t.string :phone
      t.text :address
      t.date :order_date
      t.string :product_name
      t.decimal :quantity_ordered_liters
      t.integer :quantity_ordered_bottles
      t.decimal :unit_price
      t.decimal :total_amount
      t.string :payment_status
      t.decimal :amount_paid
      t.string :delivery_status
      t.date :delivered_date

      t.timestamps
    end
  end
end
