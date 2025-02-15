class ClaAssignment < ApplicationRecord
  belongs_to :cla_course, class_name: 'ClaCourse', foreign_key: 'cla_course_id'
  has_many :cla_submissions,  optional: true
end
