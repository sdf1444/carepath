class CreateCareTransitions < ActiveRecord::Migration[7.2]
  def change
    create_table :care_transitions do |t|
      t.references :patient, null: false, foreign_key: true
      t.references :clinician, null: false, foreign_key: { to_table: :users }
      t.integer :from_stage, null: false
      t.integer :to_stage, null: false
      t.text :reason, null: false
      t.timestamps
    end
  end
end
