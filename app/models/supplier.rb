class Supplier < ApplicationRecord
  has_many :raw_materials

  validates :supplier_name, presence: true
  validates :phone, presence: true
end
