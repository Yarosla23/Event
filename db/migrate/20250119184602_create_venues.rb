class CreateVenues < ActiveRecord::Migration[7.0]
  def change
    create_table :venues do |t|
      t.string :name
      t.string :venue_type
      t.text :description
      t.string :address
      t.string :city
      t.string :district
      t.string :phone
      t.string :email
      t.string :website

      t.timestamps
    end
  end
end
