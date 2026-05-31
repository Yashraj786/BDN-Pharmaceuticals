class ReportsController < ApplicationController
  def index
    @month = params[:month] ? Date.parse("#{params[:month]}-01") : Date.today.beginning_of_month
    @month_end = @month.end_of_month

    @revenue   = SalesOrder.where(order_date: @month..@month_end).sum(:amount_paid).to_f
    @expenses  = Expense.where(expense_date: @month..@month_end).sum(:amount).to_f
    @net_profit = @revenue - @expenses

    @orders     = SalesOrder.where(order_date: @month..@month_end).order(:order_date)
    @expense_list = Expense.where(expense_date: @month..@month_end).order(:expense_date)
    @batches    = ProductionBatch.where(batch_date: @month..@month_end).order(:batch_date)
    @outstanding_orders = SalesOrder.where("total_amount > amount_paid").order(:order_date)
  end

  def daily_production
    @date   = params[:date] ? Date.parse(params[:date]) : Date.today
    @batches = ProductionBatch.where(batch_date: @date).order(:batch_name)
  end

  def daily_sales
    @date   = params[:date] ? Date.parse(params[:date]) : Date.today
    @orders = SalesOrder.where(order_date: @date).order(:created_at)
    @total  = @orders.sum(:total_amount)
    @paid   = @orders.sum(:amount_paid)
  end

  def inventory_report
    @items = Inventory.order(:product_name)
    @total_value = @items.sum { |i| (i.quantity_liters || 0) * (i.cost_per_liter || 0) }
  end

  def customer_credit
    @customers = Customer.order(:customer_name)
    @orders_owing = SalesOrder.where("total_amount > amount_paid")
                               .order(:customer_name)
  end

  def backup
    data = {
      customers:    Customer.all.as_json,
      raw_materials: RawMaterial.all.as_json,
      sales_orders: SalesOrder.all.as_json,
      expenses:     Expense.all.as_json,
      inventory:    Inventory.all.as_json,
      batches:      ProductionBatch.all.as_json
    }
    send_data data.to_json,
              filename: "bdn_backup_#{Date.today}.json",
              type: "application/json",
              disposition: "attachment"
  end
end
