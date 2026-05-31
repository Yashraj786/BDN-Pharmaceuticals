class ProductionBatch < ApplicationRecord
  has_one :quality_log, dependent: :destroy

  STATUSES = %w[in_progress completed quality_checked ready_sale].freeze
  PRODUCTS = ["Phenol", "Disinfectant", "Cleaner", "Acid Solution", "Sanitizer", "Custom"].freeze

  validates :batch_name, presence: true
  validates :product_name, presence: true
  validates :quantity_produced_liters, numericality: { greater_than: 0 }
  validates :batch_status, inclusion: { in: STATUSES }

  before_validation :set_defaults

  def profit
    return 0 unless expected_sale_price.present? && production_cost.present?
    (expected_sale_price * quantity_produced_liters) - production_cost
  end

  def profit_per_liter
    return 0 unless quantity_produced_liters.to_f > 0
    profit / quantity_produced_liters
  end

  def status_label
    case batch_status
    when "in_progress"    then "In Progress"
    when "completed"      then "Completed"
    when "quality_checked" then "Quality Checked"
    when "ready_sale"     then "Ready for Sale"
    else batch_status.humanize
    end
  end

  def status_color
    case batch_status
    when "in_progress"    then "yellow"
    when "completed"      then "blue"
    when "quality_checked" then "purple"
    when "ready_sale"     then "green"
    else "gray"
    end
  end

  def mark_ready_for_sale!
    update!(batch_status: "ready_sale", completed_date: Date.today)
    sync_to_inventory
  end

  private

  def set_defaults
    self.batch_date  ||= Date.today
    self.batch_status ||= "in_progress"
    self.raw_materials_used ||= {}
  end

  def sync_to_inventory
    inv = Inventory.find_or_initialize_by(product_name: product_name)
    inv.quantity_liters  = (inv.quantity_liters || 0) + quantity_produced_liters
    inv.cost_per_liter   = production_cost / quantity_produced_liters if quantity_produced_liters > 0
    inv.sale_price_per_liter ||= expected_sale_price
    inv.last_updated_at  = Time.current
    inv.save!
  end
end
