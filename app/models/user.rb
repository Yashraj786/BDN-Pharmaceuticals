class User < ApplicationRecord
  has_secure_password

  ROLES = %w[admin manager worker].freeze

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :role, inclusion: { in: ROLES }
  validates :password, length: { minimum: 4 }, if: -> { new_record? || !password.nil? }

  def admin?
    role == "admin"
  end

  def manager?
    role == "manager"
  end
end
