class DashboardController < ApplicationController
  def index
    today = Date.today
    month_start = today.beginning_of_month

    # Raw Materials
    @total_materials  = RawMaterial.count
    @low_stock_count  = RawMaterial.low_stock.count

    # Production
    @today_batches   = ProductionBatch.where(batch_date: today).count
    @week_batches    = ProductionBatch.where(batch_date: today.beginning_of_week..today).count
    @pending_batches = ProductionBatch.where(batch_status: %w[in_progress completed]).count
    @ready_batches   = ProductionBatch.where(batch_status: "ready_sale").count

    # Inventory
    @total_inventory_liters = Inventory.sum(:quantity_liters).to_f.round(0)

    # Sales
    @today_sales   = SalesOrder.where(order_date: today).count
    @today_revenue = SalesOrder.where(order_date: today).sum(:amount_paid).to_f.round(0)

    # Finance
    @outstanding      = SalesOrder.sum("total_amount - amount_paid").to_f.round(0)
    @month_revenue    = SalesOrder.where(order_date: month_start..today).sum(:amount_paid).to_f.round(0)
    @month_expenses   = Expense.where(expense_date: month_start..today).sum(:amount).to_f.round(0)
    @net_profit       = (@month_revenue - @month_expenses).round(0)

    # Quality checks pending
    @quality_pending = ProductionBatch.where(batch_status: "completed")
                                      .left_joins(:quality_log)
                                      .where(quality_logs: { id: nil }).count
    @quality_done    = QualityLog.where(checked_date: month_start..today).count

    # Low stock materials list
    @low_materials = RawMaterial.low_stock.limit(5)
  end
end
