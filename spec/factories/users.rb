FactoryBot.define do
  factory :user do
    sequence(:name){|n| "Clinician #{n}"}
    sequence(:email){|n| "clinician#{n}@example.test"}
    password { "password123" }
    role { :clinician }
  end
end
