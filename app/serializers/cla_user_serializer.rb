class ClaUserSerializer < ActiveModel::Serializer
  attributes :id, :email, :cla_cohort_id, :cla_role_id, :name, :phone_number, :birthday, :course_completion_rate

  def cla_cohort_name
    object.cla_cohort&.name
  end

  def cla_role_name
    object.cla_role&.name
  end

  # Get course completion rate dynamically
  def course_completion_rate
    object.course_completion_rate(object.cla_cohort_id)
  end
end
