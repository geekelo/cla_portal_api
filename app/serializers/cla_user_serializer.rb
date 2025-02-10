class ClaUserSerializer < ActiveModel::Serializer
  attributes :id, :email, :cla_cohort_id, :cla_role_id, :name
end
