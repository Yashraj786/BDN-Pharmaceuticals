class QualityLog < ApplicationRecord
  belongs_to :production_batch

  validates :purity_test, inclusion: { in: %w[pass fail] }

  after_save :update_batch_status

  def overall_pass?
    purity_test == "pass" &&
      (color_ok != false) &&
      (smell_ok != false)
  end

  private

  def update_batch_status
    if overall_pass?
      production_batch.update_columns(batch_status: "quality_checked")
    end
  end
end
