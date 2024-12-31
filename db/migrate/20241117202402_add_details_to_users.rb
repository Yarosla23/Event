class AddDetailsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :name, :string
    add_column :users, :birthday_year, :integer
    add_column :users, :status, :string
    add_column :users, :avatar, :string
  end
end
