class QualityLogsController < ApplicationController
  before_action :set_batch, only: %i[new create]
  before_action :set_log,   only: %i[show]

  def index
    @pending = ProductionBatch.where(batch_status: "completed")
                              .left_joins(:quality_log)
                              .where(quality_logs: { id: nil })
                              .order(batch_date: :desc)
    @checked = QualityLog.includes(:production_batch).order(checked_date: :desc).limit(20)
  end

  def show; end

  def new
    @log = QualityLog.new(batch_id: @batch.id, checked_date: Date.today)
  end

  def create
    @log = QualityLog.new(log_params.merge(batch_id: @batch.id, checked_date: Date.today))
    @log.checked_by = current_user.name

    if @log.save
      if @log.overall_pass?
        redirect_to quality_logs_path, notice: "✅ QUALITY PASSED! Batch is now Quality Checked."
      else
        redirect_to quality_logs_path, notice: "❌ QUALITY FAILED. Batch needs review."
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_batch
    @batch = ProductionBatch.find(params[:batch_id])
  end

  def set_log
    @log = QualityLog.find(params[:id])
  end

  def log_params
    params.require(:quality_log).permit(
      :ph_level, :density, :color_ok, :smell_ok, :purity_test,
      :ph_ok, :density_ok, :notes
    )
  end
end
