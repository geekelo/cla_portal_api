class ClaContributionsScoreSerializer < ActiveModel::Serializer
  attributes :id, :cla_contribution_id, :cla_user_id, :cla_cohort_id, :cla_course_id, :score, :created_at, :updated_at

  belongs_to :cla_contribution
end 