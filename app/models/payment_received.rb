class PaymentReceived < ApplicationRecord
  belongs_to :sales_order

  METHODS = %w[cash check bank].freeze

  validates :amount_received, numericality: { greater_than: 0 }
  validates :payment_method, inclusion: { in: METHODS }
end
