class ClaContributionsSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :due_date, :cla_cohort_id, :cla_course_id, :student_score, :course_name

  def student_score
    return nil unless current_user
    
    if current_user.cla_role&.name == 'student'
      score_record = object.cla_contributions_scores.find_by(cla_user_id: current_user.id)
      score_record&.score
    else
      score_record = object.cla_contributions_scores.find_by(cla_user_id: object.cla_user_id)
      score_record&.score
    end
  end

  def course_name
    object&.cla_course.name
  end
end