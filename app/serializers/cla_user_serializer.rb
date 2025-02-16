class ClaUserSerializer < ActiveModel::Serializer
  attributes :id, :default_id, :email, :cla_cohort_id, :cla_role_id, :name, :phone_number, :birthday,
             :cla_cohort_name, :cla_role_name

  def id
    object&.user_id
  end

  def default_id
    object&.id
  end

  def cla_cohort_name
    object&.cla_cohort&.name
  end

  def cla_role_name
    object&.cla_role&.name
  end
end
