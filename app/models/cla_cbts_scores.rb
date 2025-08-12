class ClaCbtsScores < ApplicationRecord
  belongs_to :cla_cbt, dependent: :destroy
  belongs_to :cla_user
  belongs_to :cla_cohort
end
