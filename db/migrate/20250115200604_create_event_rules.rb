class CreateEventRules < ActiveRecord::Migration[7.0]
  def change
    create_table :event_rules do |t|
      t.references :event, null: false, foreign_key: true
      t.string :rules
      t.boolean :consent

      t.timestamps
    end
  end
end
