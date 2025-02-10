module Api
  module V1
    class ClaSubmissionController < ApplicationController
      def index
        if params[:cla_user_id].present?
          submissions = ClaSubmission.where(cla_student_id: params[:cla_user_id])
        else
          submissions = ClaSubmission.all
        end
      
        render json: submissions, each_serializer: ClaSubmissionSerializer, status: :ok
        # GET /cla_submissions?cla_user_id=<student_id>
      end

      def create
        submission = ClaSubmission.new(submission_params)
        if submission.save
          render json: { message: 'Submission created successfully' }, status: :created
        else
          render json: { error: 'Something went wrong creating submission' }, status: :unprocessable_entity
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
        params.require(:cla_submission).permit(:content, :cla_assignment_id, :cla_user_id)
      end
    end
  end
end
