module ClaDashboardCourseStatsHelper
  # ✅ Calculate cohort completion rate
  def self.course_completion_rate(cohort_id, user_id)
    total_courses = ClaCourse.where(cla_cohort_id: cohort_id).count
    completed_courses = completed_courses_count(cohort_id, user_id)

    completion_percentage = total_courses.zero? ? 0 : (completed_courses.to_f / total_courses * 100).round(2)

    {
      total_courses:,
      completed_courses:,
      completion_percentage:
    }
  end

  # ✅ Determine the number of courses completed in a cohort
  def self.completed_courses_count(cohort_id, user_id)
    # 1. Get all course IDs for the cohort
    cohort_course_ids = ClaCourse.where(cla_cohort_id: cohort_id).pluck(:id)

    # 2. Get all assignments linked to those courses
    assignment_course_map = ClaAssignment.where(cla_course_id: cohort_course_ids)
      .pluck(:id, :cla_course_id)
      .to_h

    # 3. Get courses where at least one submission exists for the given user
    completed_course_ids = ClaSubmission.where(cla_student_id: user_id, cla_assignment_id: assignment_course_map.keys)
      .pluck(:cla_assignment_id)
      .map { |assignment_id| assignment_course_map[assignment_id] }
      .uniq

    completed_course_ids.count
  end
end
