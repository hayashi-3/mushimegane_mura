class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.references :participant, foreign_key: true
      t.datetime :date_and_time, null: false
      t.string :event_name, null: false
      t.text :content, null: false
      t.integer :number_of_reservations, null: false
      t.string :image_id
      t.boolean :is_active, null: false, default: true
      t.timestamps
    end
  end
end
