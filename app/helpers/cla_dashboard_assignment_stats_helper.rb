module ClaDashboardAssignmentStatsHelper
  def self.user_submission_percentage(user_id, course_id)
    user = ClaUser.find_by(user_id:)
    return { error: 'User not found' } unless user
    return { error: 'User is not assigned to any cohort' } unless user.cla_cohort_id

    cohort_id = user.cla_cohort_id

    # 1. Get all courses for the user's cohort
    # cohort_course_ids = ClaCourse.where(cla_cohort_id: cohort_id).pluck(:id)

    # 2. Get all assignments for these courses
    cohort_assignment_ids = ClaAssignment.where(cla_course_id: course_id).pluck(:id)

    # 3. Get the total number of assignments in the cohort
    total_assignments = cohort_assignment_ids.count

    # 4. Get the number of submissions made by the user
    total_submissions = ClaSubmission.where(cla_student_id: user_id, cla_assignment_id: cohort_assignment_ids).count

    # 5. Calculate submission percentage
    submission_percentage = total_assignments.zero? ? 0 : (total_submissions.to_f / total_assignments * 100).round(2)

    submission_points = ((submission_percentage * 25)/100).round(2)

    {
      total_submissions:,
      total_assignments:,
      submission_percentage:,
      submission_points:
    }
  end
end
