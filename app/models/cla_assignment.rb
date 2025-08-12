class ClaAssignment < ApplicationRecord
  belongs_to :cla_course, class_name: 'ClaCourse', foreign_key: 'cla_course_id', dependent: :destroy
  has_many :submissions, class_name: 'ClaSubmission', foreign_key: 'cla_assignment_id'
end
