class CreateEventPhotos < ActiveRecord::Migration[7.0]
  def change
    create_table :event_photos do |t|
      t.references :event, null: false, foreign_key: true
      t.string :photo

      t.timestamps
    end
  end
end
