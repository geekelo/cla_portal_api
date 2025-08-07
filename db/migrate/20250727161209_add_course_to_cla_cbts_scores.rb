class AddCourseToClaCbtsScores < ActiveRecord::Migration[7.1]
  def change
    add_reference :cla_cbts_scores, :cla_course, type: :uuid, null: true, foreign_key: false
  end
end 