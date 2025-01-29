class AddUserIdToVenues < ActiveRecord::Migration[7.0]
  def change
    add_reference :venues, :user, null: false, foreign_key: true
  end
end
