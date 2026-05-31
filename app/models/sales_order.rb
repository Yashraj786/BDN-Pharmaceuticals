class SalesOrder < ApplicationRecord
  belongs_to :customer, optional: true
  has_many :payments_received, dependent: :destroy

  PAYMENT_STATUSES = %w[pending partial paid].freeze
  DELIVERY_STATUSES = %w[pending delivered].freeze

  validates :customer_name, presence: true
  validates :product_name, presence: true
  validates :unit_price, numericality: { greater_than: 0 }

  before_save :calculate_total
  after_create :deduct_inventory

  def outstanding_amount
    (total_amount || 0) - (amount_paid || 0)
  end

  def payment_status_label
    case payment_status
    when "pending"  then "Not Paid"
    when "partial"  then "Partial Payment"
    when "paid"     then "Fully Paid"
    else payment_status.to_s.humanize
    end
  end

  def record_payment!(amount, method = "cash")
    paid = (self.amount_paid || 0) + amount.to_f
    self.amount_paid = paid
    self.payment_status = paid >= total_amount ? "paid" : "partial"
    save!
    payments_received.create!(
      amount_received: amount,
      payment_method: method,
      received_date: Date.today
    )
  end

  private

  def calculate_total
    qty = (quantity_ordered_liters || 0) + (quantity_ordered_bottles || 0)
    self.total_amount = qty * (unit_price || 0)
    self.amount_paid  ||= 0
    self.payment_status ||= "pending"
    self.delivery_status ||= "pending"
    self.order_date ||= Date.today
  end

  def deduct_inventory
    liters = quantity_ordered_liters.to_f
    return unless liters > 0
    inv = Inventory.find_by(product_name: product_name)
    inv&.deduct!(liters)
  end
end
