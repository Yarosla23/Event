class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.string :event_type
      t.datetime :start_time
      t.datetime :end_time
      t.string :location
      t.string :location_link
      t.string :event_format

      t.timestamps
    end
  end
end
