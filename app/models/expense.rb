class Expense < ApplicationRecord
  TYPES = %w[raw_material worker_salary utility packaging transport other].freeze
  METHODS = %w[cash check bank].freeze

  validates :expense_type, inclusion: { in: TYPES }
  validates :amount, numericality: { greater_than: 0 }
  validates :expense_date, presence: true

  before_validation { self.expense_date ||= Date.today }

  def type_label
    expense_type.humanize
  end
end
