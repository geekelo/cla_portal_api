class ClaUser < ApplicationRecord
  validates :name, presence: true, length: { minimum: 3, maximum: 50 }
  validates :email, presence: true, uniqueness: true,
                    format: { with: URI::MailTo::EMAIL_REGEXP, message: 'must be a valid email format' }
  validates :password, presence: true, length: { minimum: 6 }, if: :password_required?

  has_secure_password
  belongs_to :cla_cohort, optional: true
  belongs_to :cla_role, optional: true

  has_many :cla_attendances
  has_many :cla_live_classes, through: :cla_attendances
  has_many :cla_submissions
  has_many :cla_courses 

  before_create :generate_user_id

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
