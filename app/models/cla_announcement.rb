class ClaAnnouncement < ApplicationRecord
  belongs_to :cla_cohort, optional: true
  belongs_to :cla_user, optional: true

  
  scope :for_cohort, ->(cohort_id) { where(cla_cohort_id: cohort_id) }
  scope :for_user, ->(user_id) { where(cla_user_id: user_id) }
  scope :recent, -> { order(created_at: :desc) }
end
