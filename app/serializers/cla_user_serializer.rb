class ClaUserSerializer < ActiveModel::Serializer
  attributes :id, :email, :cla_cohort_id, :cla_role_id, :name

  def cla_cohort_name
    object.cla_cohort&.name
  end

  def cla_role_name
    object.cla_role&.name
  end
end
