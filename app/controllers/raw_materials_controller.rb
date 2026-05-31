class RawMaterialsController < ApplicationController
  before_action :set_material, only: %i[show edit update destroy add_stock add_stock_form]

  def index
    @materials = RawMaterial.includes(:supplier).order(:material_name)
    @low_count = @materials.select(&:low_stock?).count
  end

  def show; end

  def new
    @material = RawMaterial.new
    @suppliers = Supplier.order(:supplier_name)
  end

  def create
    @material = RawMaterial.new(material_params)
    if @material.save
      redirect_to raw_materials_path, notice: "Material added successfully!"
    else
      @suppliers = Supplier.order(:supplier_name)
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @suppliers = Supplier.order(:supplier_name)
  end

  def update
    if @material.update(material_params)
      redirect_to raw_materials_path, notice: "Material updated successfully!"
    else
      @suppliers = Supplier.order(:supplier_name)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @material.destroy
    redirect_to raw_materials_path, notice: "Material deleted."
  end

  # GET shows form, POST processes it
  def add_stock
    return render :show if request.get?
    qty  = params[:quantity_added].to_f
    cost = params[:cost_per_unit]
    if qty > 0
      @material.add_stock!(qty, cost)
      redirect_to raw_materials_path, notice: "Stock updated! New total: #{@material.current_stock_quantity} #{@material.unit_of_measurement}"
    else
      redirect_to raw_materials_path, alert: "Please enter a valid quantity."
    end
  end

  private

  def set_material
    @material = RawMaterial.find(params[:id])
  end

  def material_params
    params.require(:raw_material).permit(
      :material_name, :unit_of_measurement, :current_stock_quantity,
      :reorder_level, :supplier_id, :cost_per_unit
    )
  end
end
