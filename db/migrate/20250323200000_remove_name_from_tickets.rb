class RemoveNameFromTickets < ActiveRecord::Migration[7.0]
  def change
    remove_column :tickets, :name, :string
  end
end 