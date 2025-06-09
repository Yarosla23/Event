class CreateVenuePhotos < ActiveRecord::Migration[7.0]
  def change
    create_table :venue_photos do |t|
      t.references :venue, null: false, foreign_key: true
      t.string :photo
      t.string :media_type, default: 'photo' # 'photo' or 'video'
      t.string :video_url # For storing video URLs if needed

      t.timestamps
    end
  end
end 