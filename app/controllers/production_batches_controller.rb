class ProductionBatchesController < ApplicationController
  before_action :set_batch, only: %i[show edit update destroy update_status mark_ready]

  def index
    @batches = ProductionBatch.order(batch_date: :desc, created_at: :desc)
    @filter  = params[:filter] || "all"
    @batches = @batches.where(batch_date: Date.today) if @filter == "today"
    @batches = @batches.where(batch_date: Date.today.beginning_of_week..Date.today) if @filter == "week"
    @batches = @batches.where(batch_status: params[:status]) if params[:status].present?
  end

  def show; end

  def new
    @batch = ProductionBatch.new(batch_date: Date.today, batch_status: "in_progress")
    next_num = ProductionBatch.count + 1
    @batch.batch_name = "Batch-#{next_num.to_s.rjust(3, '0')}"
  end

  def create
    @batch = ProductionBatch.new(batch_params)
    if @batch.save
      redirect_to production_batches_path, notice: "Batch '#{@batch.batch_name}' started successfully!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @batch.update(batch_params)
      redirect_to production_batches_path, notice: "Batch updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @batch.destroy
    redirect_to production_batches_path, notice: "Batch deleted."
  end

  def update_status
    new_status = params[:batch_status]
    if ProductionBatch::STATUSES.include?(new_status)
      if new_status == "ready_sale"
        @batch.mark_ready_for_sale!
        redirect_to production_batches_path, notice: "Batch moved to Ready for Sale! Inventory updated."
      else
        @batch.update!(batch_status: new_status)
        redirect_to production_batches_path, notice: "Status updated to #{@batch.status_label}."
      end
    else
      redirect_to production_batches_path, alert: "Invalid status."
    end
  end

  def mark_ready
    @batch.mark_ready_for_sale!
    redirect_to production_batches_path, notice: "#{@batch.batch_name} is now Ready for Sale! Inventory updated automatically."
  rescue => e
    redirect_to production_batches_path, alert: "Error: #{e.message}"
  end

  private

  def set_batch
    @batch = ProductionBatch.find(params[:id])
  end

  def batch_params
    params.require(:production_batch).permit(
      :batch_name, :batch_date, :product_name, :quantity_produced_liters,
      :production_cost, :expected_sale_price, :batch_status
    )
  end
end
