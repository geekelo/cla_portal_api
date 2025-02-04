class ClaRole < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :cla_users, class_name: 'ClaUser', foreign_key: 'cla_role_id'
end
