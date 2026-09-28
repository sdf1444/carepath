class CreateOutcomes < ActiveRecord::Migration[7.2]
  def change
    create_table :outcomes do |t|
      t.references :patient, null: false, foreign_key: true
      t.string :label, null: false
      t.integer :score, null: false
      t.date :recorded_on, null: false
      t.timestamps
    end
  end
end
