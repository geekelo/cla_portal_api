module Api
  module V1
    class ClaAttendancesController < ApplicationController
      def create
        attendance = ClaAttendance.new(attendance_params)
        
        if attendance.save
          render json: { message: 'Attendance recorded successfully', attendance: attendance }, status: :created
        else
          render json: { error: attendance.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def missing_attendance
        cla_live_class_id = params[:cla_live_class_id]
        cla_cohort_id = params[:cla_cohort_id]

        return render json: { error: "Live class ID and cohort ID are required" }, status: :unprocessable_entity unless cla_live_class_id && cla_cohort_id

        # Get all users in the cohort
        cohort_users = ClaUser.where(cla_cohort_id: cla_cohort_id)

        # Get user IDs already marked in attendance for this live class
        recorded_user_ids = ClaAttendance.where(cla_live_class_id: cla_live_class_id).pluck(:cla_user_id)

        # Get users who are NOT in the attendance table
        missing_users = cohort_users.where.not(id: recorded_user_ids)

        render json: { missing_users: missing_users }, status: :ok
      end

      private

      def find_live_class
        @live_class = ClaLiveClass.find_by(id: params[:cla_live_class_id])
        return render json: { error: 'Live class not found' }, status: :not_found unless @live_class
      end

      def find_user
        @user = ClaUser.find_by(user_id: params[:cla_user_id])
        return render json: { error: 'User not found' }, status: :not_found unless @user
      end

      def find_cohort
        @cohort = ClaCohort.find_by(id: params[:cla_cohort_id])
        return render json: { error: 'Cohort not found' }, status: :not_found unless @cohort
      end

      def attendance_params
        params.require(:cla_attendance).permit(:cla_live_class_id, :cla_user_id, :cla_cohort_id, :present)
      end
    end
  end
end
