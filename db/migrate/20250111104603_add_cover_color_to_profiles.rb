class AddCoverColorToProfiles < ActiveRecord::Migration[7.0]
  def change
    add_column :profiles, :cover_color, :string
  end
end
