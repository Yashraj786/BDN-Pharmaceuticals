class CreateExpenses < ActiveRecord::Migration[7.2]
  def change
    create_table :expenses do |t|
      t.string :expense_type
      t.decimal :amount
      t.date :expense_date
      t.text :description
      t.string :payment_method

      t.timestamps
    end
  end
end
