class ClaUser < ApplicationRecord
  validates :name, presence: true, length: { minimum: 3, maximum: 50 }
  validates :email, presence: true, uniqueness: true,
                    format: { with: URI::MailTo::EMAIL_REGEXP, message: 'must be a valid email format' }
  validates :password, presence: true, length: { minimum: 6 }, if: :password_required?
  validates :cla_role_id, presence: true

  has_secure_password
  belongs_to :cla_cohort, optional: true
  belongs_to :cla_role, optional: false

  before_create :generate_user_id

  private

  # Generate custom user_id if not provided
  def generate_user_id
    timestamp = Time.current.strftime('%H%M%S') # Gets current time in HHMMSS format
    random_letter = ('A'..'Z').to_a.sample # Random uppercase letter
    random_code = SecureRandom.alphanumeric(5).upcase # Generate 5-character alphanumeric

    self.user_id ||= "CLA#{random_letter}#{timestamp}#{random_code}"

    # Ensure uniqueness
    generate_user_id if ClaUser.exists?(user_id: self.user_id)
  end

  # Ensure password validation only when needed
  def password_required?
    new_record? || password.present?
  end
end
