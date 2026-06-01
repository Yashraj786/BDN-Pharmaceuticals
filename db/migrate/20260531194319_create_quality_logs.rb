class CreateQualityLogs < ActiveRecord::Migration[7.2]
  def change
    create_table :quality_logs do |t|
      t.integer :production_batch_id
      t.decimal :ph_level
      t.decimal :density
      t.boolean :color_ok
      t.boolean :smell_ok
      t.string :purity_test
      t.boolean :ph_ok
      t.boolean :density_ok
      t.string :checked_by
      t.date :checked_date
      t.text :notes

      t.timestamps
    end
  end
end
