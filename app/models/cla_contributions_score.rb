class ClaContributionsScore < ApplicationRecord
  belongs_to :cla_contribution
  belongs_to :cla_user
  belongs_to :cla_cohort
end
