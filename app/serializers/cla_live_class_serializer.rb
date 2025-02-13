class ClaLiveClassSerializer < ActiveModel::Serializer
  attributes :id, :name, :date, :time, :duration, :zoom_link, :cla_course_id, :cla_cohort_id, :cla_user_id
end
