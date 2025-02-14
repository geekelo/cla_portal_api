class ClaLiveClass < ApplicationRecord
  belongs_to :cla_course, class_name: 'ClaCourse', foreign_key: 'cla_course_id'
  belongs_to :cla_cohort, optional: true
end
