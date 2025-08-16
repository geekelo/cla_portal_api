class ClaAssignmentSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :due_date, :cla_course_id, :cla_user_id, :submitted, :course_name, :student_score

  def course_name
    object&.cla_course.name
  end

  def student_score
    return nil unless current_user

    if current_user.cla_role.name == 'student'
      object&.cla_submissions&.find_by(cla_student_id: current_user.id)&.score
    else
      nil
    end
  end
end
