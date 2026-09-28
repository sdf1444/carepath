class DashboardController < ApplicationController
  def index
    @patients = visible_patients.order(:next_action_on)
  end
  private
  def visible_patients
    current_user.clinician? ? current_user.patients : Patient.all
  end
end
