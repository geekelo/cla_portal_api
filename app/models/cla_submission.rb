class ClaSubmission < ApplicationRecord
  belongs_to :cla_assignment, optional: true
  belongs_to :cla_cohort, optional: true
  belongs_to :cla_course, optional: true
  belongs_to :cla_student, class_name: 'ClaUser', foreign_key: 'cla_student_id'
end
