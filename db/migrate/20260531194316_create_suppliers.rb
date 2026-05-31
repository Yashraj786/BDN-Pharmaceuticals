class CreateSuppliers < ActiveRecord::Migration[7.2]
  def change
    create_table :suppliers do |t|
      t.string :supplier_name
      t.string :phone
      t.string :contact_person
      t.text :address
      t.string :city
      t.integer :delivery_days

      t.timestamps
    end
  end
end
