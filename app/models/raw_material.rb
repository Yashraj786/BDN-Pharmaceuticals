class RawMaterial < ApplicationRecord
  belongs_to :supplier, optional: true

  validates :material_name, presence: true
  validates :unit_of_measurement, presence: true
  validates :current_stock_quantity, numericality: { greater_than_or_equal_to: 0 }
  validates :reorder_level, numericality: { greater_than_or_equal_to: 0 }

  scope :low_stock, -> { where("current_stock_quantity <= reorder_level") }
  scope :ok_stock,  -> { where("current_stock_quantity > reorder_level") }

  def low_stock?
    current_stock_quantity <= reorder_level
  end

  def add_stock!(qty, cost = nil)
    self.current_stock_quantity = (current_stock_quantity || 0) + qty.to_f
    self.cost_per_unit = cost.to_f if cost.present? && cost.to_f > 0
    self.last_updated_at = Time.current
    save!
  end
end
