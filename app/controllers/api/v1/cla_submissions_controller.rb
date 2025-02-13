module Api
  module V1
    class ClaSubmissionsController < ApplicationController
      def index
        if params[:cla_user_id].present?
          submissions = ClaSubmission.where("cla_student_id = ? OR cla_facilitator_id = ?", params[:cla_user_id], params[:cla_user_id])
        else
          submissions = ClaSubmission.all
        end      
      
        render json: submissions, each_serializer: ClaSubmissionSerializer, status: :ok
      end

      def create
        submission = ClaSubmission.new(submission_params)
        if submission.save
          render json: submission, status: :created
        else
          Rails.logger.info "Validation Errors: #{submission.errors.full_messages}"
          render json: { errors: submission.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        submission = ClaSubmission.find(params[:id])
        if submission.update(submission_params)
          render json: { message: 'Submission updated successfully' }, status: :ok
        else
          render json: { error: 'Something went wrong updating submission' }, status: :unprocessable_entity
        end
      end

      def destroy
        submission = ClaSubmission.find(params[:id])
        submission.destroy
        render json: { message: 'Submission deleted successfully' }, status: :ok
      end

      private

      def submission_params
        params.require(:cla_submission).permit(:download_link, :cla_assignment_id, :cla_student_id, :cla_facilitator_id)
      end
    end
  end
end
