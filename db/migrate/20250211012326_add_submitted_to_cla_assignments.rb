class AddSubmittedToClaAssignments < ActiveRecord::Migration[7.1]
  def up
    add_column :cla_assignments, :submitted, :boolean, null: true, default: false
  end

  def down
    remove_column :cla_assignments, :submitted
  end
end
