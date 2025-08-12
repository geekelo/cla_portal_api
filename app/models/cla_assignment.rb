class ClaAssignment < ApplicationRecord
  belongs_to :cla_course, class_name: 'ClaCourse', foreign_key: 'cla_course_id'
  has_many :submissions, class_name: 'ClaSubmission', foreign_key: 'cla_assignment_id'
  belongs_to :cla_cohort, class_name: 'ClaCohort', foreign_key: 'cla_cohort_id'
end
