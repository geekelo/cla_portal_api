module ClaDashboardScoreStatsHelper
  def self.user_score_percentage(user_id)
    user = ClaUser.find_by(user_id: user_id)
    return { error: "User not found" } unless user
    return { error: "User is not assigned to any cohort" } unless user.cla_cohort_id

    cohort_id = user.cla_cohort_id

    # 1. Get all courses for the user's cohort
    cohort_course_ids = ClaCourse.where(cla_cohort_id: cohort_id).pluck(:id)

    # 2. Get all assignments for these courses
    cohort_assignment_ids = ClaAssignment.where(cla_course_id: cohort_course_ids).pluck(:id)

    # 3. Calculate the total expected score (each assignment is out of 100)
    total_possible_score = cohort_assignment_ids.count * 100

    # 4. Get the sum of scores from all submissions for this user
    total_user_score = ClaSubmission.where(cla_student_id: user_id, cla_assignment_id: cohort_assignment_ids)
                                    .sum(:score)

    # 5. Calculate the percentage score
    score_percentage = total_possible_score.zero? ? 0 : (total_user_score.to_f / total_possible_score * 100).round(2)

    {
      total_user_score: total_user_score,
      total_possible_score: total_possible_score,
      score_percentage: score_percentage
    }
  end
end
