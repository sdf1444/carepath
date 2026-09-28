FactoryBot.define do
  factory :patient do
    sequence(:reference){|n| "CP-#{2000+n}"}
    sequence(:name){|n| "Synthetic Patient #{n}"}
    stage { :assessment }
    association :clinician, factory: :user
    next_action { "Review" }
    next_action_on { Date.current }
  end
end
