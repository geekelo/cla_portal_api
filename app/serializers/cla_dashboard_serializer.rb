class ClaDashboardSerializer < ActiveModel::Serializer
  attributes :id, :name, :course_completion_rate

  # Get course completion rate dynamically
  def course_completion_rate
    object.course_completion_rate(object.cla_cohort_id)
  end
end
