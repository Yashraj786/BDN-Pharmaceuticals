class SalesOrdersController < ApplicationController
  before_action :set_order, only: %i[show edit update destroy collect_payment mark_delivered]

  def index
    @orders = SalesOrder.order(order_date: :desc, created_at: :desc)
    case params[:filter]
    when "today" then @orders = @orders.where(order_date: Date.today)
    when "week"  then @orders = @orders.where(order_date: Date.today.beginning_of_week..Date.today)
    when "month" then @orders = @orders.where(order_date: Date.today.beginning_of_month..Date.today)
    end
    @filter = params[:filter] || "all"
  end

  def show; end

  def new
    @order = SalesOrder.new(order_date: Date.today)
    @customers  = Customer.order(:customer_name)
    @products   = Inventory.where("quantity_liters > 0").pluck(:product_name, :sale_price_per_liter)
  end

  def create
    @order = SalesOrder.new(order_params)
    # Link customer if exists
    if params[:sales_order][:customer_id].blank? && params[:sales_order][:customer_name].present?
      cust = Customer.find_or_create_by(customer_name: params[:sales_order][:customer_name]) do |c|
        c.phone = params[:sales_order][:phone] || "N/A"
      end
      @order.customer_id = cust.id
    end

    if @order.save
      redirect_to sales_orders_path, notice: "Sale recorded! Total: ₹#{@order.total_amount}"
    else
      @customers = Customer.order(:customer_name)
      @products  = Inventory.where("quantity_liters > 0").pluck(:product_name, :sale_price_per_liter)
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @customers = Customer.order(:customer_name)
    @products  = Inventory.pluck(:product_name, :sale_price_per_liter)
  end

  def update
    if @order.update(order_params)
      redirect_to sales_orders_path, notice: "Order updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @order.destroy
    redirect_to sales_orders_path, notice: "Order deleted."
  end

  def collect_payment
    amount = params[:amount_received].to_f
    method = params[:payment_method] || "cash"
    if amount > 0
      @order.record_payment!(amount, method)
      redirect_to sales_orders_path, notice: "Payment of ₹#{amount} recorded! Outstanding: ₹#{@order.outstanding_amount}"
    else
      redirect_to sales_orders_path, alert: "Please enter a valid amount."
    end
  end

  def mark_delivered
    @order.update!(delivery_status: "delivered", delivered_date: Date.today)
    redirect_to sales_orders_path, notice: "Order marked as Delivered!"
  end

  private

  def set_order
    @order = SalesOrder.find(params[:id])
  end

  def order_params
    params.require(:sales_order).permit(
      :customer_id, :customer_name, :phone, :address,
      :order_date, :product_name, :quantity_ordered_liters,
      :quantity_ordered_bottles, :unit_price, :payment_status,
      :amount_paid, :delivery_status
    )
  end
end
