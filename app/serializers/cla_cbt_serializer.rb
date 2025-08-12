class ClaCbtSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :due_date, :url, :cla_cohort_id, :cla_course_id, :student_score

  def student_score
    return nil unless current_user
    
    if current_user.cla_role.name == 'student'
      object.cla_cbts_scores.find_by(cla_user_id: current_user.id).score
    else
      object.cla_cbts_scores.find_by(cla_user_id: object.cla_user_id).score
    end
  end
end
