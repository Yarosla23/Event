class CreatePolicies < ActiveRecord::Migration[7.0]
  def change
    create_table :policies do |t|
      t.references :venue, null: false, foreign_key: true
      t.boolean :smoking_allowed
      t.boolean :alcohol_allowed
      t.boolean :noise_restrictions

      t.timestamps
    end
  end
end
