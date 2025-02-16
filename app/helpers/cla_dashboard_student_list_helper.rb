module ClaDashboardStudentListHelper
  def self.student_list(cohort_id)
    cohort_id = cohort_id.to_s  # Ensure cohort_id is treated as a string

    # Get all students in the cohort
    students = ClaUser.where("cla_cohort_id::text = ?", cohort_id)
                      .where(role: 'student')
                      .order(:first_name, :last_name)
                      .map do |student|
                        {
                          user_id: student.id,
                          first_name: student.first_name,
                          last_name: student.last_name,
                          email: student.email
                        }
                      end

    students
  end
end
