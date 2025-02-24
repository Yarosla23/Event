class AddTagsToEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :tags, :text, array: true, default: []
  end
end
