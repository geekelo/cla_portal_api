class ClaDashboardController < ApplicationController
  def course_stats
    cohort_id = params[:cohort_id]
    return render json: { error: "Cohort ID is required" }, status: :unprocessable_entity unless cohort_id

    stats = ClaDashboardHelper.course_completion_rate(cohort_id)
    render json: stats, status: :ok
  end
end
