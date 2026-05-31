# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2026_05_31_194325) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "customers", force: :cascade do |t|
    t.string "customer_name"
    t.string "phone"
    t.text "address"
    t.string "city"
    t.string "contact_person"
    t.decimal "credit_limit"
    t.decimal "outstanding_amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "expenses", force: :cascade do |t|
    t.string "expense_type"
    t.decimal "amount"
    t.date "expense_date"
    t.text "description"
    t.string "payment_method"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "inventories", force: :cascade do |t|
    t.string "product_name"
    t.decimal "quantity_liters"
    t.integer "quantity_bottles"
    t.string "storage_location"
    t.decimal "cost_per_liter"
    t.decimal "sale_price_per_liter"
    t.datetime "last_updated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payments_receiveds", force: :cascade do |t|
    t.integer "sales_order_id"
    t.decimal "amount_received"
    t.string "payment_method"
    t.date "received_date"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "production_batches", force: :cascade do |t|
    t.string "batch_name"
    t.date "batch_date"
    t.string "product_name"
    t.decimal "quantity_produced_liters"
    t.decimal "production_cost"
    t.decimal "expected_sale_price"
    t.string "batch_status"
    t.jsonb "raw_materials_used"
    t.date "completed_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "quality_logs", force: :cascade do |t|
    t.integer "batch_id"
    t.decimal "ph_level"
    t.decimal "density"
    t.boolean "color_ok"
    t.boolean "smell_ok"
    t.string "purity_test"
    t.boolean "ph_ok"
    t.boolean "density_ok"
    t.string "checked_by"
    t.date "checked_date"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "raw_materials", force: :cascade do |t|
    t.string "material_name"
    t.string "unit_of_measurement"
    t.decimal "current_stock_quantity"
    t.decimal "reorder_level"
    t.integer "supplier_id"
    t.decimal "cost_per_unit"
    t.datetime "last_updated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sales_orders", force: :cascade do |t|
    t.integer "customer_id"
    t.string "customer_name"
    t.string "phone"
    t.text "address"
    t.date "order_date"
    t.string "product_name"
    t.decimal "quantity_ordered_liters"
    t.integer "quantity_ordered_bottles"
    t.decimal "unit_price"
    t.decimal "total_amount"
    t.string "payment_status"
    t.decimal "amount_paid"
    t.string "delivery_status"
    t.date "delivered_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "suppliers", force: :cascade do |t|
    t.string "supplier_name"
    t.string "phone"
    t.string "contact_person"
    t.text "address"
    t.string "city"
    t.integer "delivery_days"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "phone"
    t.string "password_digest"
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
end
