class ClaCohort < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :cla_users, lambda {
                         joins(:cla_role).where(cla_roles: { name: 'student' })
                       }, class_name: 'ClaUser', foreign_key: 'cla_cohort_id'
  has_many :courses, class_name: 'ClaCourse', foreign_key: 'cla_cohort_id'

  has_many :cla_attendances
end
