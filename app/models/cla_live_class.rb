class CreateClaLiveClass < ApplicationRecord
  belongs_to :cla_course, class_name: 'ClaCourse', foreign_key: 'cla_course_id'
  belongs_to :facilitators, lambda {
    joins(:cla_role).where(cla_roles: { name: 'facilitator' })
  }, class_name: 'ClaUser', foreign_key: 'cla_user_id'
end
