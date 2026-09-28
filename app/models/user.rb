class User < ApplicationRecord
  has_secure_password
  enum :role, { clinician: 0, clinical_lead: 1, admin: 2 }
  has_many :patients, foreign_key: :clinician_id, dependent: :restrict_with_error
  validates :name, :email, presence: true
  validates :email, uniqueness: true
end
