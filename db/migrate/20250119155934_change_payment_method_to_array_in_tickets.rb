class ChangePaymentMethodToArrayInTickets < ActiveRecord::Migration[7.0]
  def change
    change_column :tickets, :payment_method, :string, array: true, default: [], using: 'payment_method::text[]'
  end
end
