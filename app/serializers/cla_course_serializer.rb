class ClaCourseSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :start_date, :end_date, :created_at, :updated_at

  has_many :topics
  has_many :assignments
  has_many :live_classes
end
