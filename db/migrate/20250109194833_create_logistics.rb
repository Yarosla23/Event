class CreateLogistics < ActiveRecord::Migration[7.0]
  def change
    create_table :logistics do |t|
      t.references :event, null: false, foreign_key: true
      t.text :organizers
      t.text :contact_info
      t.text :technical_requirements
      t.text :special_instructions

      t.timestamps
    end
  end
end
