class ClaContributionsSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :due_date, :cla_cohort_id, :cla_course_id, :student_score

  def student_score
    if current_user.cla_role.name == 'student'
      object.cla_contributions_scores.find_by(cla_user_id: current_user.id).score
    else
      object.cla_contributions_scores.find_by(cla_user_id: object.cla_user_id).score
    end
  end
end