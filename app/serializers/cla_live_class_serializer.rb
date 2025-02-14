class ClaLiveClassSerializer < ActiveModel::Serializer
  attributes :id, :name, :date, :time, :duration, :zoom_link, :cla_course_id, :cla_cohort_id, :cla_user_id,
  :cla_cohort_start_date, :cla_cohort_end_date

  def cla_cohort_start_date
    object.cla_cohort&.start_date
  end

  def cla_cohort_end_date
    object.cla_cohort&.end_date
  end
end
