class ClaCbt < ApplicationRecord
  belongs_to :cla_cohort
  belongs_to :cla_course
  has_many :cla_cbts_scores
end