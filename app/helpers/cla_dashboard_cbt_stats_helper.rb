module ClaDashboardCbtStatsHelper
  def self.user_cbt_stats(user_id, course_id)
    user = ClaUser.find_by(user_id:)
    return { error: 'User not found' } unless user
    return { error: 'User is not assigned to any cohort' } unless user.cla_cohort_id

    cohort_id = user.cla_cohort_id

    total_cbts = ClaCbt.where(cla_course_id: course_id).count

    # Get total cbts scores of user
    total_cbts_scores = ClaCbtsScore.where(cla_user_id: user_id, cla_course_id: course_id).sum(:score)

    cbt_percentage = total_cbts_scores.to_f / (total_cbts.to_f * 100) * 100

    # Get cbt points
    cbt_points = ((cbt_percentage * 20)/100).round(2)

    {
      total_cbts_scores:,
      cbt_points:
    }
  end
end