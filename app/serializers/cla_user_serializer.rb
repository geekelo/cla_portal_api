class ClaUserSerializer < ActiveModel::Serializer
  attributes :id, :email, :cla_cohort_id, :cla_role_id, :name, :phone_number, :birthday,
             :cla_cohort_name, :cla_role_name

  def cla_cohort_name
    object.cla_cohort&.name
  end

  def cla_role_name
    object.cla_role&.name
  end
end
