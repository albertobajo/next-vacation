class CreateActivities < ActiveRecord::Migration[6.0]
  def change
    create_table :activities do |t|
      t.string :name
      t.integer :minutes_spent
      t.st_point :lonlat
      t.references :category, null: false, foreign_key: true
      t.references :district, null: false, foreign_key: true
      t.references :location, null: false, foreign_key: true

      t.timestamps
    end

    add_index :activities, :name
    add_index :activities, :lonlat, using: :gist
  end
end
