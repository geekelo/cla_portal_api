class ClaCbtSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :due_date, :url, :cla_cohort_id, :cla_course_id, :student_score, :course_name

  def student_score
    return nil unless current_user

    if current_user.cla_role.name == 'student'
      object&.cla_cbts_scores&.find_by(cla_user_id: current_user.id)&.score
    else
      nil
    end
  end

  def course_name
    object&.cla_course.name
  end
end
