class ClaUser < ApplicationRecord
  validates :name, presence: true, length: { minimum: 3, maximum: 50 }
  validates :email, presence: true, uniqueness: true,
                    format: { with: URI::MailTo::EMAIL_REGEXP, message: 'must be a valid email format' }
  validates :password, presence: true, length: { minimum: 6 }, if: :password_required?

  has_secure_password
  belongs_to :cla_cohort, optional: true
  belongs_to :cla_role, optional: true

  before_create :generate_user_id

  # Method to calculate cohort completion rate
  def course_completion_rate(cohort_id)
    total_courses = ClaCourse.where(cla_cohort_id: cohort_id).count
    completed_courses = ClaCourse
      .joins(:cla_assignments => :cla_submissions)
      .where(cla_cohort_id: cohort_id)
      .distinct
      .count
  
    completion_percentage = total_courses.zero? ? 0 : (completed_courses.to_f / total_courses * 100).round(2)
  
    {
      total_courses: total_courses,
      completed_courses: completed_courses,
      completion_percentage: completion_percentage
    }
  end

  private

  # Generate custom user_id if not provided
  def generate_user_id
    loop do
      timestamp = Time.current.strftime('%H%M%S') # Current time in HHMMSS
      random_letter = ('A'..'Z').to_a.sample # Random uppercase letter
      random_code = SecureRandom.alphanumeric(5).upcase # 5-character alphanumeric
  
      temp_user_id = "CLA#{random_letter}#{timestamp}#{random_code}"
  
      unless ClaUser.exists?(user_id: temp_user_id)
        self.user_id = temp_user_id
        break
      end
    end
  end
  
  # Ensure password validation only when needed
  def password_required?
    new_record? || password.present?
  end
end
