class CareTransitionsController < ApplicationController
  def create
    patient = Patient.find(params[:patient_id])
    CarePath::Transition.call(patient:, clinician: current_user, to: params[:to_stage], reason: params[:reason])
    redirect_to patient_path(patient), notice: "Care pathway updated."
  rescue CarePath::Transition::InvalidTransition, CarePath::Transition::NotAuthorised => e
    redirect_to patient_path(patient), alert: e.message.presence || "You are not authorised to update this patient."
  end
end
