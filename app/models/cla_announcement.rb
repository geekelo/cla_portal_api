class ClaAnnouncement < ApplicationRecord
  belongs_to :cla_cohort
  belongs_to :cla_user, optional: true
end
