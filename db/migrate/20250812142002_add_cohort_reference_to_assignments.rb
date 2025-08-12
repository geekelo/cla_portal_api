class AddCohortReferenceToAssignments < ActiveRecord::Migration[7.1]
  def change
    add_reference :cla_assignments, :cla_cohort, type: :integer, null: true, foreign_key: false
  end
end 