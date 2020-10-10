class CreateInfos < ActiveRecord::Migration[5.2]
  def change
    create_table :infos do |t|
      t.references :participant, foreign_key: true, null: false
      t.text :message, null: false
      t.timestamps
    end
  end
end
