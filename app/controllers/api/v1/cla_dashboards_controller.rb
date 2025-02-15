module Api
  module V1
    class ClaDashboardsController < ApplicationController
      def course_stats
        cohort_id = params[:cla_cohort_id]
        user_id = params[:cla_user_id]
        return render json: { error: 'Cohort ID is required' }, status: :unprocessable_entity unless cohort_id

        stats = ClaDashboardCourseStatsHelper.course_completion_rate(cohort_id, user_id)
        render json: stats, status: :ok
      end

      def score_stats
        user_id = params[:cla_user_id]
        return render json: { error: 'User ID is required' }, status: :unprocessable_entity unless user_id

        stats = ClaDashboardScoreStatsHelper.user_score_percentage(user_id)
        render json: stats, status: :ok
      end
    end
  end
end
