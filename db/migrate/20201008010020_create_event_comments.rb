class CreateEventComments < ActiveRecord::Migration[5.2]
  def change
    create_table :event_comments do |t|
      t.references :participant, foreign_key: true, null:false
      t.text :comment, null: false
      t.timestamps
    end
  end
end
