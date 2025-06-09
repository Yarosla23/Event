class CreateMediaFiles < ActiveRecord::Migration[7.0]
  def change
    create_table :media_files do |t|
      t.references :attachable, polymorphic: true, null: false
      t.string :file
      t.string :file_type
      t.string :content_type
      t.integer :file_size
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end 