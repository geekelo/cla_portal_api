class ClaCourseSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :start_date, :end_date, :created_at, :updated_at, :cla_user_id
end
