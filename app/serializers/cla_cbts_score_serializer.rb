class ClaCbtsScoreSerializer < ActiveModel::Serializer
  attributes :id, :cla_cbt_id, :cla_user_id, :cla_cohort_id, :score, :created_at, :updated_at

  belongs_to :cla_cbt
  belongs_to :cla_user
  belongs_to :cla_cohort
end 