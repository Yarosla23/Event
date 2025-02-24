class CreateVenues < ActiveRecord::Migration[7.0]
  def change
    create_table :venues do |t|
      t.string :name
      t.string :venue_type
      t.text :description
      t.string :address
      t.string :phone
      t.string :email
      t.string :website
      t.integer :area
      t.integer :max_participants
      t.string :details

      t.timestamps
    end
  end
end
