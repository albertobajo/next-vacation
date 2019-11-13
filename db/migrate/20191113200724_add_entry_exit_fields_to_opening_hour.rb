class AddEntryExitFieldsToOpeningHour < ActiveRecord::Migration[6.0]
  def change
    add_column :opening_hours, :first_exit_at, :integer
    add_column :opening_hours, :last_entry_at, :integer

    add_index :opening_hours, :first_exit_at
    add_index :opening_hours, :last_entry_at
  end
end
