class OverdueActionJob < ApplicationJob
  queue_as :default
  def perform
    Patient.needs_attention.find_each do |patient|
      Rails.logger.info("CarePath overdue action: #{patient.reference} - #{patient.next_action}")
    end
  end
end
