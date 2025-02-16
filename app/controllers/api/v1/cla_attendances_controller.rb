module Api
  module V1
    class ClaAttendancesController < ApplicationController
      before_action :find_live_class
      before_action :find_user
      before_action :find_cohort

      def create
        attendance = Attendance.new(attendance_params)
        
        if attendance.save
          render json: { message: 'Attendance recorded successfully', attendance: attendance }, status: :created
        else
          render json: { error: attendance.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def find_live_class
        @live_class = ClaLiveClass.find_by(id: params[:cla_live_class_id])
        return render json: { error: 'Live class not found' }, status: :not_found unless @live_class
      end

      def find_user
        @user = ClaUser.find_by(id: params[:cla_user_id])
        return render json: { error: 'User not found' }, status: :not_found unless @user
      end

      def find_cohort
        @cohort = ClaCohort.find_by(id: params[:cla_cohort_id])
        return render json: { error: 'Cohort not found' }, status: :not_found unless @cohort
      end

      def attendance_params
        params.require(:attendance).permit(:cla_live_class_id, :cla_user_id, :cla_cohort_id, :present)
      end
    end
  end
end
