class ClaSubmission < ApplicationRecord
  belongs_to :cla_assignment, optional: true
  belongs_to :cla_cohort, optional: true
end
