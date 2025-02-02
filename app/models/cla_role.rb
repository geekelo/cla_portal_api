class ClaRole < ApplicationRecord
  validates :name, presence: true, uniqueness: true
end
