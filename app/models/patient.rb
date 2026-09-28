class Patient < ApplicationRecord
  enum :stage, { referral: 0, assessment: 1, treatment: 2, review: 3, discharged: 4 }
  belongs_to :clinician, class_name: "User"
  has_many :care_transitions, dependent: :restrict_with_error
  has_many :outcomes, dependent: :destroy
  validates :reference, :name, :stage, presence: true
  validates :reference, uniqueness: true
  scope :needs_attention, -> { where(next_action_on: ..Date.current) }
end
