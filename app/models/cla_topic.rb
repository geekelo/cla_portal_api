class ClaTopic < ApplicationRecord
  belongs_to :cla_course, class_name: 'ClaCourse', foreign_key: 'cla_course_id'
end
