class UpdateVenuesTable < ActiveRecord::Migration[7.0]
  def change
    change_column_null :venues, :name, false
    change_column_null :venues, :max_participants, false
    change_column_null :venues, :area, false
    change_column_null :venues, :email, false
    change_column_null :venues, :phone, false
    change_column_null :venues, :address, false

    change_column :venues, :venue_type, :text, array: true, default: [], using: "string_to_array(venue_type, ',')"
  end
end
