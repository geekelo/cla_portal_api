class ClaAssignmentSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :due_date, :cla_course_id, :cla_user_id
end
