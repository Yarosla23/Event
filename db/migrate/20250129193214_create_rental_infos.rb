class CreateRentalInfos < ActiveRecord::Migration[7.0]
  def change
    create_table :rental_infos do |t|
      t.references :venue, null: false, foreign_key: true
      t.decimal :price, null: false
      t.text :discounts
      t.integer :min_rental_duration_hours, default: 0
      t.text :payment_terms
      t.time :working_hours_start, null: false
      t.time :working_hours_end, null: false
      t.text :rules # Правила аренды
      t.text :disclaimer # Отказ от ответственности

      t.timestamps
    end
  end
end
