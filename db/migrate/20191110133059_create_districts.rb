class CreateDistricts < ActiveRecord::Migration[6.0]
  def change
    create_table :districts do |t|
      t.string :name
      t.references :city, null: false, foreign_key: true

      t.timestamps
    end
    add_index :districts, :name
  end
end
