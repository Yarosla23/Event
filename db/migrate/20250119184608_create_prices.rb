class CreatePrices < ActiveRecord::Migration[7.0]
  def change
    create_table :prices do |t|
      t.references :venue, null: false, foreign_key: true
      t.decimal :amount
      t.string :currency
      t.integer :min_duration

      t.timestamps
    end
  end
end
