class ChangeForeignKeysToStringInClaSubmissions < ActiveRecord::Migration[7.1]
  def up
    # Change foreign key columns from uuid to string
    change_column :cla_submissions, :cla_assignment_id, :string
    change_column :cla_submissions, :cla_student_id, :string
    change_column :cla_submissions, :cla_facilitator_id, :string
  end

  def down
    # Revert the foreign key columns from string back to uuid
    change_column :cla_submissions, :cla_assignment_id, :uuid
    change_column :cla_submissions, :cla_student_id, :uuid
    change_column :cla_submissions, :cla_facilitator_id, :uuid
  end
end
