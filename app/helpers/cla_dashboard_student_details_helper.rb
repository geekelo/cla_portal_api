module ClaDashboardStudentDetailsHelper
  def self.student_details(user_id)
    user_id = user_id.to_s  # Ensure user_id is treated as a string

    # Get student details
    student = ClaUser.where("user_id::text = ?", user_id)
                     .where(role: 'student')
                     .map do |student|
                       {
                         user_id: student.user_id,
                         name: student.name,
                         email: student.email,
                         cohort_id: student.cohort_id&.name,
                         role: student.cla_role&.name,
                         phone_number: student.phone_number,
                          birthday: student.birthday
                        }

    student
end
