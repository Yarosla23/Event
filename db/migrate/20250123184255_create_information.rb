class CreateInformation < ActiveRecord::Migration[7.0]
  def change
    create_table :information do |t|
      t.references :venue, null: false, foreign_key: true
      t.text :document
      t.text :description
      t.string :calendar

      t.timestamps
    end
  end
end
