class CreateServices < ActiveRecord::Migration[7.0]
  def change
    create_table :services do |t|
      t.references :venue, null: false, foreign_key: true
      t.boolean :technical_equipment, default: false
      t.boolean :furniture, default: false
      t.boolean :decoration, default: false
      t.boolean :cleaning_after_event, default: false
      t.boolean :security, default: false
      t.text :additional_services

      t.timestamps
    end
  end
end
