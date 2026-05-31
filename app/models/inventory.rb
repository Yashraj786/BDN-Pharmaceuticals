class Inventory < ApplicationRecord
  validates :product_name, presence: true

  def profit_margin_percent
    return 0 unless sale_price_per_liter.to_f > 0 && cost_per_liter.to_f > 0
    ((sale_price_per_liter - cost_per_liter) / sale_price_per_liter * 100).round(1)
  end

  def stock_status
    qty = quantity_liters.to_f
    if qty > 500
      "good"
    elsif qty > 100
      "medium"
    else
      "low"
    end
  end

  def deduct!(liters)
    self.quantity_liters = (quantity_liters || 0) - liters.to_f
    self.last_updated_at = Time.current
    save!
  end
end
