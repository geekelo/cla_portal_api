class ClaSubmission < ApplicationRecord
  belongs_to :cla_assignment, class_name: 'ClaAssignment', foreign_key: 'cla_assignment_id'
  belongs_to :cla_user, class_name: 'ClaUser', foreign_key: 'cla_user_id'
end
