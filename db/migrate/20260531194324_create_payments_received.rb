class CreatePaymentsReceived < ActiveRecord::Migration[7.2]
  def change
    create_table :payments_receiveds do |t|
      t.integer :sales_order_id
      t.decimal :amount_received
      t.string :payment_method
      t.date :received_date
      t.text :notes

      t.timestamps
    end
  end
end
