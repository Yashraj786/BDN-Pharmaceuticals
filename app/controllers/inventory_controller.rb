class InventoryController < ApplicationController
  before_action :set_item, only: %i[show edit update adjust]

  def index
    @items = Inventory.order(:product_name)
  end

  def show; end

  def edit; end

  def update
    if @item.update(inventory_params)
      redirect_to inventory_index_path, notice: "Inventory updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def adjust
    adj = params[:adjustment].to_f
    note = params[:note]
    @item.quantity_liters = (@item.quantity_liters || 0) + adj
    @item.last_updated_at = Time.current
    if @item.save
      redirect_to inventory_index_path, notice: "Stock adjusted by #{adj} liters."
    else
      render :show, status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Inventory.find(params[:id])
  end

  def inventory_params
    params.require(:inventory).permit(
      :product_name, :quantity_liters, :quantity_bottles,
      :storage_location, :cost_per_liter, :sale_price_per_liter
    )
  end
end
