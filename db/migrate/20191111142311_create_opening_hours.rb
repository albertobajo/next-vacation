class CreateOpeningHours < ActiveRecord::Migration[6.0]
  def change
    create_table :opening_hours do |t|
      t.integer :day_of_week
      t.integer :opens_at
      t.integer :closes_at
      t.references :activity, null: false, foreign_key: true

      t.timestamps
    end
    add_index :opening_hours, :day_of_week
    add_index :opening_hours, :opens_at
    add_index :opening_hours, :closes_at
  end
end
