module ClaDashboardDeskStatsHelper
  def self.user_desk_stats(cohort_id)
    # Get total courses for the cohort
    total_courses = ClaCourse.where(cla_cohort_id: cohort_id).count

    # Get total assignments for all courses in the cohort
    total_assignments = ClaAssignment.joins(:cla_course)
                                     .where(cla_courses: { cla_cohort_id: cohort_id })
                                     .count

    # Get total live classes for the cohort
    total_live_classes = ClaLiveClass.where(cla_cohort_id: cohort_id).count

    # Get total users in the cohort
    total_users = ClaUser.where(cla_cohort_id: cohort_id).count

    # Get total submissions without scores
    total_submissions_without_score = ClaSubmission.where(cla_score: nil)
                                                   .joins(:cla_assignment)
                                                   .where(cla_assignments: { cla_course_id: ClaCourse.where(cla_cohort_id: cohort_id) })
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
