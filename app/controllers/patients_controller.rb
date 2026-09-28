class PatientsController < ApplicationController
  def index
    @patients = visible_patients
    @patients = @patients.where(stage: params[:stage]) if params[:stage].present?
    @patients = @patients.where("name ILIKE :q OR reference ILIKE :q", q: "%#{params[:q]}%") if params[:q].present?
    @patients = @patients.order(:name)
  end
  def show
    @patient = visible_patients.find(params[:id])
  end
  private
  def visible_patients
    current_user.clinician? ? current_user.patients : Patient.all
  end
end
