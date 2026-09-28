CareTransition.delete_all; Outcome.delete_all; Patient.delete_all; User.delete_all
clinician = User.create!(name:"Dr Alex Smith", email:"clinician@example.test", password:"password123", role: :clinician)
lead = User.create!(name:"Dr Maya Patel", email:"lead@example.test", password:"password123", role: :clinical_lead)
admin = User.create!(name:"CarePath Admin", email:"admin@example.test", password:"password123", role: :admin)
patients = [
  ["CP-1042","Emily Carter",:treatment,"Review appointment",Date.current+2],
  ["CP-1043","James Wilson",:assessment,"Complete assessment",Date.current],
  ["CP-1044","Sophie Brown",:review,"Review outcome",Date.current-1],
  ["CP-1045","Daniel Taylor",:treatment,"Questionnaire due",Date.current+4],
  ["CP-1046","Aisha Khan",:referral,"Initial triage",Date.current+1]
].map { |ref,name,stage,action,date| Patient.create!(reference:ref,name:,stage:,clinician:,next_action:action,next_action_on:date) }
patients.each_with_index do |p,i|
  p.outcomes.create!(label:"Assessment",score:18+i,recorded_on:Date.current-56)
  p.outcomes.create!(label:"Week 4",score:14+i,recorded_on:Date.current-28) if p.treatment? || p.review?
  p.outcomes.create!(label:"Week 8",score:10+i,recorded_on:Date.current) if p.review?
end
puts "Seeded demo users and synthetic patients. Login: clinician@example.test / password123"
