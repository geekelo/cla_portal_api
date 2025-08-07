class AddCohortToClaSubmissions < ActiveRecord::Migration[7.1]
  def change
    add_reference :cla_submissions, :cla_cohort, type: :uuid, null: true, foreign_key: false
    add_reference :cla_submissions, :cla_course, type: :uuid, null: true, foreign_key: false
  end
end
