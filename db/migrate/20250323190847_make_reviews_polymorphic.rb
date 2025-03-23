class MakeReviewsPolymorphic < ActiveRecord::Migration[7.0]
  def change
    remove_index :reviews, name: "index_reviews_on_venue_id"
    remove_column :reviews, :venue_id, :bigint

    add_column :reviews, :reviewable_id, :bigint, null: false
    add_column :reviews, :reviewable_type, :string, null: false

    add_index :reviews, [:reviewable_id, :reviewable_type]
  end
end