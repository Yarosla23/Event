class CreateInformation < ActiveRecord::Migration[7.0]
  def change
    create_table :information do |t|
      t.references :venue, null: false, foreign_key: true
      t.text :document
      t.text :description
      t.boolean :smoking_allowed
      t.boolean :alcohol_allowed
      t.boolean :noise_restrictions
      t.string :calendar
      t.text :event_types, default: [], array: true
      t.text :restrictions 
      
      t.timestamps
    end
  end
end
