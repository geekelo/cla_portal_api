module ClaDashboardDeskStatsHelper
  def self.user_desk_stats(cohort_id)
    cohort_id = cohort_id.to_s  # Ensure cohort_id is treated as a string

    # Get total courses for the cohort
    total_courses = ClaCourse.where("cla_cohort_id::text = ?", cohort_id).count

    # Get total assignments for all courses in the cohort
    total_assignments = ClaAssignment.joins(:cla_course)
                                     .where("cla_courses.cla_cohort_id::text = ?", cohort_id)
                                     .count

    # Get total live classes for the cohort
    total_live_classes = ClaLiveClass.where("cla_cohort_id::text = ?", cohort_id).count

    # Get total users in the cohort
    total_users = ClaUser.where("cla_cohort_id::text = ?", cohort_id).count

    # Get total submissions without scores
    total_submissions_without_score = ClaSubmission.where(cla_score: nil)
                                                   .joins("INNER JOIN cla_assignments ON cla_assignments.id::text = cla_submissions.cla_assignment_id::text")
                                                   .joins("INNER JOIN cla_courses ON cla_courses.id::text = cla_assignments.cla_course_id::text")
                                                   .where("cla_courses.cla_cohort_id::text = ?", cohort_id)
                                                   .count

    {
      total_courses: total_courses,
      total_assignments: total_assignments,
      total_live_classes: total_live_classes,
      total_users: total_users,
      total_submissions_without_score: total_submissions_without_score
    }
  end
end
