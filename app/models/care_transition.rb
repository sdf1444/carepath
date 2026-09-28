class CareTransition < ApplicationRecord
  belongs_to :patient
  belongs_to :clinician, class_name: "User"
  enum :from_stage, Patient.stages, prefix: :from
  enum :to_stage, Patient.stages, prefix: :to
  validates :reason, presence: true
end
