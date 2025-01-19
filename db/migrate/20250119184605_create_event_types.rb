class CreateEventTypes < ActiveRecord::Migration[7.0]
  def change
    create_table :event_types do |t|
      t.references :venue, null: false, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
