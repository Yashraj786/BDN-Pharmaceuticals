puts "Creating seed data..."

# Admin User
User.find_or_create_by(email: "admin@bdn.com") do |u|
  u.name     = "Admin Manager"
  u.phone    = "9876543210"
  u.role     = "admin"
  u.password = "admin"
end
puts "Admin user: admin@bdn.com / admin"

User.find_or_create_by(email: "manager@bdn.com") do |u|
  u.name     = "Ram Kumar"
  u.phone    = "9876543211"
  u.role     = "manager"
  u.password = "1234"
end

# Suppliers
[
  { supplier_name: "Raj Chemicals",    phone: "9811234567", contact_person: "Rajesh Gupta",  city: "Delhi",   delivery_days: 2 },
  { supplier_name: "Sharma Industries",phone: "9823456789", contact_person: "Suresh Sharma", city: "Mumbai",  delivery_days: 4 },
  { supplier_name: "National Solvents",phone: "9834567890", contact_person: "Priya Nair",    city: "Chennai", delivery_days: 5 },
].each { |s| Supplier.find_or_create_by(supplier_name: s[:supplier_name]) { |sup| sup.assign_attributes(s) } }

s1 = Supplier.find_by(supplier_name: "Raj Chemicals")
s2 = Supplier.find_by(supplier_name: "Sharma Industries")
s3 = Supplier.find_by(supplier_name: "National Solvents")

# Raw Materials
[
  { material_name: "Phenol (Pure)",      unit_of_measurement: "liter",  current_stock_quantity: 500,  reorder_level: 100, cost_per_unit: 150, supplier: s1 },
  { material_name: "Caustic Soda",       unit_of_measurement: "kg",     current_stock_quantity: 200,  reorder_level: 50,  cost_per_unit: 45,  supplier: s2 },
  { material_name: "Distilled Water",    unit_of_measurement: "liter",  current_stock_quantity: 1000, reorder_level: 200, cost_per_unit: 5,   supplier: s1 },
  { material_name: "Hydrochloric Acid",  unit_of_measurement: "liter",  current_stock_quantity: 80,   reorder_level: 100, cost_per_unit: 120, supplier: s3 },
  { material_name: "Surfactant",         unit_of_measurement: "kg",     current_stock_quantity: 150,  reorder_level: 30,  cost_per_unit: 250, supplier: s2 },
  { material_name: "Packaging Bottles",  unit_of_measurement: "bottle", current_stock_quantity: 2000, reorder_level: 500, cost_per_unit: 8,   supplier: s1 },
].each { |m| RawMaterial.find_or_create_by(material_name: m[:material_name]) { |rm| rm.assign_attributes(m.merge(last_updated_at: Time.current)) } }

# Production Batches
[
  { batch_name: "Batch-001", batch_date: 5.days.ago.to_date, product_name: "Phenol",       quantity_produced_liters: 200, production_cost: 18000, expected_sale_price: 120, batch_status: "ready_sale" },
  { batch_name: "Batch-002", batch_date: 3.days.ago.to_date, product_name: "Disinfectant", quantity_produced_liters: 150, production_cost: 12000, expected_sale_price: 110, batch_status: "quality_checked" },
  { batch_name: "Batch-003", batch_date: Date.today,          product_name: "Cleaner",      quantity_produced_liters: 100, production_cost: 7500,  expected_sale_price: 95,  batch_status: "in_progress" },
  { batch_name: "Batch-004", batch_date: Date.today,          product_name: "Phenol",       quantity_produced_liters: 300, production_cost: 28000, expected_sale_price: 118, batch_status: "completed" },
].each { |b| ProductionBatch.find_or_create_by(batch_name: b[:batch_name]) { |pb| pb.assign_attributes(b) } }

# Inventory
Inventory.find_or_create_by(product_name: "Phenol") do |inv|
  inv.quantity_liters = 180; inv.cost_per_liter = 90; inv.sale_price_per_liter = 120
  inv.storage_location = "Tank A"; inv.last_updated_at = Time.current
end
Inventory.find_or_create_by(product_name: "Disinfectant") do |inv|
  inv.quantity_liters = 120; inv.cost_per_liter = 80; inv.sale_price_per_liter = 110
  inv.storage_location = "Tank B"; inv.last_updated_at = Time.current
end

# Customers
[
  { customer_name: "Apollo Hospital",   phone: "9901234567", city: "Delhi",   address: "Apollo Road, Delhi",   outstanding_amount: 0 },
  { customer_name: "City Cleaning Co.", phone: "9912345678", city: "Mumbai",  address: "Business Park, Mumbai", outstanding_amount: 5000 },
  { customer_name: "Star Pharma",       phone: "9923456789", city: "Pune",    address: "Industrial Area, Pune", outstanding_amount: 0 },
  { customer_name: "Quick Clean Ltd.",  phone: "9934567890", city: "Chennai", address: "MG Road, Chennai",      outstanding_amount: 12000 },
].each { |c| Customer.find_or_create_by(customer_name: c[:customer_name]) { |cu| cu.assign_attributes(c) } }

c1 = Customer.find_by(customer_name: "Apollo Hospital")
c2 = Customer.find_by(customer_name: "City Cleaning Co.")
c3 = Customer.find_by(customer_name: "Star Pharma")
c4 = Customer.find_by(customer_name: "Quick Clean Ltd.")

# Sales Orders
[
  { customer: c1, customer_name: "Apollo Hospital",   phone: "9901234567", order_date: Date.today,         product_name: "Phenol",       quantity_ordered_liters: 50,  unit_price: 120, total_amount: 6000,  amount_paid: 6000, payment_status: "paid",    delivery_status: "delivered" },
  { customer: c2, customer_name: "City Cleaning Co.", phone: "9912345678", order_date: 2.days.ago.to_date, product_name: "Disinfectant", quantity_ordered_liters: 100, unit_price: 110, total_amount: 11000, amount_paid: 6000, payment_status: "partial", delivery_status: "delivered" },
  { customer: c3, customer_name: "Star Pharma",       phone: "9923456789", order_date: 3.days.ago.to_date, product_name: "Phenol",       quantity_ordered_liters: 30,  unit_price: 118, total_amount: 3540,  amount_paid: 3540, payment_status: "paid",    delivery_status: "delivered" },
  { customer: c4, customer_name: "Quick Clean Ltd.",  phone: "9934567890", order_date: 5.days.ago.to_date, product_name: "Disinfectant", quantity_ordered_liters: 80,  unit_price: 108, total_amount: 8640,  amount_paid: 0,    payment_status: "pending", delivery_status: "pending" },
].each do |o|
  SalesOrder.find_or_create_by(customer_name: o[:customer_name], order_date: o[:order_date]) do |so|
    so.assign_attributes(o)
  end
end

# Expenses
[
  { expense_type: "worker_salary", amount: 45000, expense_date: Date.today.beginning_of_month, description: "Monthly salaries",           payment_method: "bank" },
  { expense_type: "utility",       amount: 8500,  expense_date: 5.days.ago.to_date,             description: "Electricity bill",          payment_method: "bank" },
  { expense_type: "raw_material",  amount: 25000, expense_date: 7.days.ago.to_date,             description: "Phenol purchase",           payment_method: "check" },
  { expense_type: "transport",     amount: 3500,  expense_date: 2.days.ago.to_date,             description: "Delivery truck charges",    payment_method: "cash" },
  { expense_type: "packaging",     amount: 4000,  expense_date: 4.days.ago.to_date,             description: "Bottles and labels",        payment_method: "cash" },
].each { |e| Expense.find_or_create_by(description: e[:description]) { |ex| ex.assign_attributes(e) } }

puts "✅ Seed data created! Login: admin@bdn.com / admin"
