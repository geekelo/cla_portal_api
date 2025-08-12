class ClaContributionsScore < ApplicationRecord
  belongs_to :cla_contribution, dependent: :destroy
  belongs_to :cla_user
  belongs_to :cla_cohort
  belongs_to :cla_course, optional: true
end
