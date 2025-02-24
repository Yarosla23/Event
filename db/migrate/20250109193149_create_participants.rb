class CreateParticipants < ActiveRecord::Migration[7.0]
  def change
    create_table :participants do |t|
      t.references :event, null: false, foreign_key: true
      t.integer :min_participants
      t.integer :max_participants
      t.string :participant_type
      t.boolean :is_private
      t.boolean :is_paid

      t.timestamps
    end
  end
end
