module ClaDashboardContributionsStatsHelper
  def self.user_contributions_stats(user_id, course_id)
    user = ClaUser.find_by(user_id:)
    return { error: 'User not found' } unless user
    return { error: 'User is not assigned to any cohort' } unless user.cla_cohort_id

    cohort_id = user.cla_cohort_id

    # Get total contributions for the course
    total_contributions = ClaContributionsScore.where(cla_course_id: course_id).count

    # Get total contributions scores of user
    total_contributions_scores = ClaContributionsScore.where(cla_user_id: user_id, cla_course_id: course_id).sum(:score)

    # Calculate percentage: (user's total score) / (number of attempted contributions × 100) × 100
    attempted_contributions = ClaContributionsScore.where(cla_user_id: user_id, cla_course_id: course_id).count
    total_contributions_percentage = attempted_contributions.zero? ? 0 : (total_contributions_scores.to_f / (attempted_contributions.to_f * 100) * 100).round(2)

    # Get contributions points
    contributions_points = ((total_contributions_percentage * 25)/100).round(2)

    {
      total_contributions_scores:,
      total_contributions_percentage:,
      contributions_points:
    }
  end
end
