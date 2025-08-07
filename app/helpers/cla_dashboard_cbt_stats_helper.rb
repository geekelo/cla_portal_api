module ClaDashboardCbtStatsHelper
  def self.user_cbt_stats(user_id, course_id)
    user = ClaUser.find_by(user_id:)
    return { error: 'User not found' } unless user
    return { error: 'User is not assigned to any cohort' } unless user.cla_cohort_id

    cohort_id = user.cla_cohort_id

    # Get total cbts scores of user
    total_cbts_scores = ClaCbtScores.where(cla_user_id: user_id, cla_course_id: course_id).sum(:score)

    # Get cbt points
    cbt_points = ((total_cbts_scores * 20)/100).round(2)

    {
      total_cbts_scores:,
      cbt_points:
    }
  end
end