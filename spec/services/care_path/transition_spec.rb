require "rails_helper"
RSpec.describe CarePath::Transition do
  let(:clinician){ create(:user) }
  let(:patient){ create(:patient, clinician:, stage: :assessment) }
  it "moves through an allowed transition and records an audit event" do
    expect { described_class.call(patient:, clinician:, to: :treatment, reason:"Assessment completed") }.to change(CareTransition,:count).by(1)
    expect(patient.reload).to be_treatment
    expect(patient.care_transitions.last.reason).to eq("Assessment completed")
  end
  it "rejects an invalid transition without changing state" do
    expect { described_class.call(patient:, clinician:, to: :discharged, reason:"Skip") }.to raise_error(CarePath::Transition::InvalidTransition)
    expect(patient.reload).to be_assessment
  end
  it "rejects another clinician" do
    outsider=create(:user)
    expect { described_class.call(patient:, clinician:outsider, to: :treatment, reason:"No") }.to raise_error(CarePath::Transition::NotAuthorised)
  end
  it "allows a clinical lead to transition a patient" do
    lead=create(:user, role: :clinical_lead)
    described_class.call(patient:, clinician:lead, to: :treatment, reason:"Lead review")
    expect(patient.reload).to be_treatment
  end
end
