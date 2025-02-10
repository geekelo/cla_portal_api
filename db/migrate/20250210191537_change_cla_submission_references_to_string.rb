class ChangeClaSubmissionReferencesToString < ActiveRecord::Migration[7.1]
  def up
    change_column :cla_submissions, :cla_assignment_id, :string, null: true
    change_column :cla_submissions, :cla_student_id, :string, null: true
    change_column :cla_submissions, :cla_facilitator_id, :string, null: true
  end

  def down
    change_column :cla_submissions, :cla_assignment_id, :uuid, null: true
    change_column :cla_submissions, :cla_student_id, :uuid, null: true
    change_column :cla_submissions, :cla_facilitator_id, :uuid, null: true
  end
end
