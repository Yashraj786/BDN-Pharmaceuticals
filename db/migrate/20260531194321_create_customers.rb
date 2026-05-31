class CreateCustomers < ActiveRecord::Migration[7.2]
  def change
    create_table :customers do |t|
      t.string :customer_name
      t.string :phone
      t.text :address
      t.string :city
      t.string :contact_person
      t.decimal :credit_limit
      t.decimal :outstanding_amount

      t.timestamps
    end
  end
end
