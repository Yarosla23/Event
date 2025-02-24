class CreateFacilities < ActiveRecord::Migration[7.0]
  def change
    create_table :facilities do |t|
      t.references :venue, null: false, foreign_key: true
      t.boolean :wifi, default: false
      t.boolean :air_conditioning, default: false
      t.boolean :audio_visual_equipment, default: false
      t.boolean :parking, default: false
      t.boolean :disabled_access, default: false
      t.boolean :kitchen, default: false
      t.integer :toilets_count, default: 0
      t.text :other_facilities

      t.timestamps
    end
  end
end
