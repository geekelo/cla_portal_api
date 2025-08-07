class AddCourseToClaContributionsScores < ActiveRecord::Migration[7.1]
  def change
    add_reference :cla_contributions_scores, :cla_course, type: :uuid, null: true, foreign_key: false
  end
end 