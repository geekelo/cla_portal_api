class AddDueDateToClaAssignments < ActiveRecord::Migration[7.1]
  def up
    add_column :cla_assignments, :due_date, :datetime, null: true
  end

  def down
    remove_column :cla_assignments, :due_date
  end
end
