class ClaContribution < ApplicationRecord
  belongs_to :cla_cohort
  belongs_to :cla_course
  has_many :cla_contributions_scores
end
