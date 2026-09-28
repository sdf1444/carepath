class CreatePatients < ActiveRecord::Migration[7.2]
  def change
    create_table :patients do |t|
      t.string :reference, null: false
      t.string :name, null: false
      t.integer :stage, null: false, default: 0
      t.references :clinician, null: false, foreign_key: { to_table: :users }
      t.date :next_action_on
      t.string :next_action
      t.integer :lock_version, null: false, default: 0
      t.timestamps
    end
    add_index :patients, :reference, unique: true
  end
end
