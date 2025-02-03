class CreateClaCourses < ApplicationRecord
  has_many :topics, class_name: "ClaTopic", foreign_key: "cla_course_id"
  has_many :assignments, class_name: "ClaAssignment", foreign_key: "cla_course_id"
  has_many :live_classes, class_name: "ClaLiveClass", foreign_key: "cla_course_id"
  belongs_to :facilitators, -> { joins(:cla_role).where(cla_roles: { name: 'student' }) }, class_name: "ClaUser", foreign_key: "cla_user_id"
  belongs_to_many :cohorts, class_name: "ClaCohort", foreign_key: "cla_cohort_id"
end
