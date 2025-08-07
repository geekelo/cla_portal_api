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

      def assignment_stats
        user_id = params[:cla_user_id]
        return render json: { error: 'User ID is required' }, status: :unprocessable_entity unless user_id

        stats = ClaDashboardAssignmentStatsHelper.user_submission_percentage(user_id)
        render json: stats, status: :ok
      end

      def attendance_stats
        user_id = params[:cla_user_id]
        return render json: { error: 'User ID is required' }, status: :unprocessable_entity unless user_id

        stats = ClaDashboardAttendanceStatsHelper.user_attendance_percentage(user_id)
        render json: stats, status: :ok
      end

      def cbt_stats
        user_id = params[:cla_user_id]
        return render json: { error: 'User ID is required' }, status: :unprocessable_entity unless user_id

        cohort_id = ClaUser.find_by(user_id:).cla_cohort_id
        course_ids = ClaCourse.where(cla_cohort_id: cohort_id).pluck(:id)

        stats = course_ids.map do |course_id|
          {
            course_id:,
            stats: ClaDashboardCbtStatsHelper.user_cbt_stats(user_id, course_id)
          }
        end
        render json: stats, status: :ok
      end

      def contributions_stats
        user_id = params[:cla_user_id]
        return render json: { error: 'User ID is required' }, status: :unprocessable_entity unless user_id

        cohort_id = ClaUser.find_by(user_id:).cla_cohort_id
        course_ids = ClaCourse.where(cla_cohort_id: cohort_id).pluck(:id)

        stats = course_ids.map do |course_id|
          {
            course_id:,
            stats: ClaDashboardContributionsStatsHelper.user_contributions_stats(user_id, course_id)
          }
        end
        render json: stats, status: :ok
      end

      def desk_stats
        cohort_id = params[:cla_cohort_id]
        return render json: { error: 'User ID is required' }, status: :unprocessable_entity unless cohort_id

        stats = ClaDashboardDeskStatsHelper.user_desk_stats(cohort_id)
        render json: stats, status: :ok
      end

      def student_list
        cohort_id = params[:cla_cohort_id]
        course_ids = ClaCourse.where(cla_cohort_id: cohort_id).pluck(:id)
        return render json: { error: 'Cohort ID is required' }, status: :unprocessable_entity unless cohort_id
      
        students = ClaDashboardStudentListHelper.student_list(cohort_id)
      
        students_with_details = students.map do |student|
          user_id = student[:user_id]
          {
            student: student,
            course_ids.map do |course_id|
              {
              course_completion_rate: ClaDashboardCourseStatsHelper.course_completion_rate(cohort_id, user_id),
              user_score_percentage: ClaDashboardScoreStatsHelper.user_score_percentage(user_id),
              user_submission_percentage: ClaDashboardAssignmentStatsHelper.user_submission_percentage(user_id, course_id),
              user_attendance_percentage: ClaDashboardAttendanceStatsHelper.user_attendance_percentage(user_id, course_id),
              user_cbt_stats: ClaDashboardCbtStatsHelper.user_cbt_stats(user_id, course_id),
              user_contribution_stats: ClaDashboardContributionsStatsHelper.user_contribution_stats(user_id, course_id)
              }
            end
          }
        end
      
        render json: students_with_details, status: :ok
      end
      
      # def student_list
      #   cohort_id = params[:cla_cohort_id]
      #   return render json: { error: 'Cohort ID is required' }, status: :unprocessable_entity unless cohort_id

      #   students = ClaDashboardStudentListHelper.student_list(cohort_id)
      #   render json: students, status: :ok
      # end

      def student_details
        cohort_id = params[:cla_cohort_id]
        user_id = params[:cla_user_id]
        return render json: { error: 'Cohort ID, User ID and Course ID are required' }, status: :unprocessable_entity unless cohort_id && user_id && course_id

        course_ids = ClaCourse.where(cla_cohort_id: cohort_id).pluck(:id)
 
        render json: {
          student: ClaDashboardStudentDetailsHelper.student_details(user_id),
          course_ids.map do |course_id|
            {
              course_id:,
              course_name: ClaCourse.find(course_id).name,
              course_completion_rate: ClaDashboardCourseStatsHelper.course_completion_rate(cohort_id, user_id),
              user_score_percentage: ClaDashboardScoreStatsHelper.user_score_percentage(user_id),
              user_submission_percentage: ClaDashboardAssignmentStatsHelper.user_submission_percentage(user_id, course_id),
              user_attendance_percentage: ClaDashboardAttendanceStatsHelper.user_attendance_percentage(user_id, course_id),
              user_cbt_stats: ClaDashboardCbtStatsHelper.user_cbt_stats(user_id, course_id),
              user_contribution_stats: ClaDashboardContributionsStatsHelper.user_contribution_stats(user_id, course_id)
            }
          end
        }, status: :ok
      end      
    end
  end
end
