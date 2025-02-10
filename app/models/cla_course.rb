class ClaCourse < ApplicationRecord
  before_create :generate_custom_id

  has_many :topics, class_name: 'ClaTopic', foreign_key: 'cla_course_id'
  has_many :assignments, class_name: 'ClaAssignment', foreign_key: 'cla_course_id'
  has_many :live_classes, class_name: 'ClaLiveClass', foreign_key: 'cla_course_id'
  has_many :cohorts, class_name: 'ClaCohort', foreign_key: 'cla_cohort_id'

  private

  def generate_custom_id
    self.id = "COURSE#{SecureRandom.hex(4).upcase}"
  end
end