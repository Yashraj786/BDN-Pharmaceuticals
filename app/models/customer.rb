class Customer < ApplicationRecord
  has_many :sales_orders

  validates :customer_name, presence: true
  validates :phone, presence: true

  def total_spent
    sales_orders.sum(:amount_paid)
  end

  def last_order_date
    sales_orders.maximum(:order_date)
  end
end
