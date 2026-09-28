require "rails_helper"
RSpec.describe OverdueActionJob do
  it "processes overdue patients" do
    create(:patient,next_action_on:Date.current-1)
    expect { described_class.perform_now }.not_to raise_error
  end
end
