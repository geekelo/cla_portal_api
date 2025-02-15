class ClaSubmission < ApplicationRecord
  belongs_to :cla_assignment, optional: true
end
