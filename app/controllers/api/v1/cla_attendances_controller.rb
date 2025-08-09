module Api
  module V1
    class ClaAttendancesController < ApplicationController
      def create
        attendance = ClaAttendance.new(attendance_params)

        if attendance.save
          render json: { message: 'Attendance recorded successfully', attendance: }, status: :created
        else
          render json: { error: attendance.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def missing_attendance
        cla_live_class_id = params[:cla_live_class_id]
        cla_cohort_id = params[:cla_cohort_id]

        unless cla_live_class_id && cla_cohort_id
          return render json: { error: 'Live class ID and cohort ID are required' },
                        status: :unprocessable_entity
        end

        # Get all users in the cohort
        cohort_users = ClaUser.where(cla_cohort_id:)

        # Get user IDs already marked in attendance for this live class
        recorded_user_ids = ClaAttendance.where(cla_live_class_id:).pluck(:cla_user_id)

        # Get users who are NOT in the attendance table
        missing_users = cohort_users.where.not(user_id: recorded_user_ids)

        render json: { missing_users: }, status: :ok
      end

      private

      def attendance_params
        params.require(:cla_attendance).permit(:cla_live_class_id, :cla_user_id, :cla_cohort_id, :present, :cla_course_id)
      end
    end
  end
end
