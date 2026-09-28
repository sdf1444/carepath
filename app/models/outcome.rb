class Outcome < ApplicationRecord
  belongs_to :patient
  validates :label, :score, :recorded_on, presence: true
  validates :score, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
end
