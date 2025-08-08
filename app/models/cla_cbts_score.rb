class ClaCbtsScore < ApplicationRecord
  belongs_to :cla_cbt
  belongs_to :cla_user
  belongs_to :cla_cohort
end 