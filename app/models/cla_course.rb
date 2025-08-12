class ClaCourse < ApplicationRecord
  before_create :generate_custom_id

  has_many :topics, class_name: 'ClaTopic', foreign_key: 'cla_course_id', dependent: :destroy
  has_many :assignments, class_name: 'ClaAssignment', foreign_key: 'cla_course_id', dependent: :destroy
  has_many :live_classes, class_name: 'ClaLiveClass', foreign_key: 'cla_course_id', dependent: :destroy
  belongs_to :cla_cohort
  has_many :cla_contributions, dependent: :destroy
  has_many :cla_cbts, dependent: :destroy
  has_many :cla_cbt_scores
  has_many :cla_contributions_scores

  private

  def generate_custom_id
    self.id = "COURSE#{SecureRandom.hex(4).upcase}"
  end
end
