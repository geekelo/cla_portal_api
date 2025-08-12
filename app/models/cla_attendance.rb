class ClaAttendance < ApplicationRecord
  belongs_to :cla_live_class
  belongs_to :cla_user
  belongs_to :cla_cohort, optional: true
  belongs_to :cla_course, optional: true

  validates :cla_live_class_id, uniqueness: { scope: :cla_user_id, message: 'User already marked for this live class' }
  validates :present, inclusion: { in: [true, false] }
end
