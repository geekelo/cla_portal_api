class ClaSubmission < ApplicationRecord
  belongs_to :cla_assignment, optional: true
  belongs_to :cla_cohort, optional: true
  belongs_to :cla_course, optional: true
  belongs_to :cla_student, class_name: 'ClaUser', foreign_key: 'cla_student_id'

  # validate that a student can only submit an assignment once
  validates :cla_student_id, uniqueness: { scope: :cla_assignment_id, message: 'Student has already been scored for this assignment' }
end
