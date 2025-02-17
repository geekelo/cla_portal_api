class ClaSubmissionSerializer < ActiveModel::Serializer
  attributes :id, :download_link, :cla_assignment_id, :cla_student_id, :cla_facilitator_id, :score, :status, :created_at
end
