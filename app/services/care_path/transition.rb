module CarePath
  class Transition
    class InvalidTransition < StandardError; end
    class NotAuthorised < StandardError; end

    ALLOWED = {
      "referral" => %w[assessment],
      "assessment" => %w[treatment],
      "treatment" => %w[review],
      "review" => %w[treatment discharged],
      "discharged" => []
    }.freeze

    def self.call(patient:, clinician:, to:, reason:)
      new(patient:, clinician:, to: to.to_s, reason:).call
    end

    def initialize(patient:, clinician:, to:, reason:)
      @patient, @clinician, @to, @reason = patient, clinician, to, reason
    end

    def call
      raise NotAuthorised unless authorised?
      raise InvalidTransition, "#{patient.stage} cannot transition to #{to}" unless ALLOWED.fetch(patient.stage).include?(to)
      raise InvalidTransition, "A reason is required" if reason.blank?

      Patient.transaction do
        patient.lock!
        from = patient.stage
        patient.update!(stage: to)
        patient.care_transitions.create!(clinician:, from_stage: from, to_stage: to, reason:)
      end
      patient
    end

    private
    attr_reader :patient, :clinician, :to, :reason
    def authorised?
      clinician.admin? || clinician.clinical_lead? || patient.clinician_id == clinician.id
    end
  end
end
