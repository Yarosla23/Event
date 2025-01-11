class CreateTickets < ActiveRecord::Migration[7.0]
  def change
    create_table :tickets do |t|
      t.references :event, null: false, foreign_key: true
      t.string :ticket_type
      t.decimal :price
      t.string :currency
      t.string :payment_method
      t.string :discount_code

      t.timestamps
    end
  end
end
