require "rails_helper"
RSpec.describe Patient do
  it "identifies overdue actions" do
    overdue=create(:patient,next_action_on:Date.current-1)
    future=create(:patient,next_action_on:Date.current+1)
    expect(Patient.needs_attention).to include(overdue)
    expect(Patient.needs_attention).not_to include(future)
  end
end
