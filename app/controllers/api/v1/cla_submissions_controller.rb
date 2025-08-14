module Api
  module V1
    class ClaSubmissionsController < ApplicationController
      before_action :authenticate_user!
      before_action :set_assignment, only: [:create, :students_without_scores]

      def index
        submissions = if params[:cla_user_id].present?
                        ClaSubmission.where('cla_student_id = ? OR cla_facilitator_id = ?', params[:cla_user_id],
                                            params[:cla_user_id])
                      else
                        ClaSubmission.all
                      end

        render json: submissions, each_serializer: ClaSubmissionSerializer, status: :ok
      end

      def create
        submission = @assignment.cla_submissions.new(submission_params)
        if submission.save
          # send email to student
          AnnouncementMailer.score_email(submission.cla_student, 'Submission Score').deliver_now
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

      def students_without_scores
        # get all students in the cohort through the course
        cohort = @assignment.cla_course.cla_cohort
        return render json: { error: 'Assignment not found or has no associated cohort' }, status: :not_found unless cohort
        
        students = cohort.cla_users
        # get all students with scores
        student_ids_with_scores = ClaSubmission.where(cla_assignment_id: @assignment.id).pluck(:cla_student_id)
        # get all students without scores
        students_without_scores = students.where.not(user_id: student_ids_with_scores)
        
        # Add debugging information
        render json: {
          total_students_in_cohort: students.count,
          students_with_scores: student_ids_with_scores.count,
          students_without_scores: students_without_scores.count,
          cohort_id: cohort.id,
          assignment_id: @assignment.id,
          students_without_scores_list: ActiveModel::Serializer::CollectionSerializer.new(students_without_scores, each_serializer: ClaUserSerializer).as_json
        }, status: :ok
      end

      private

      def submission_params
        params.require(:cla_submission).permit(:score, :cla_assignment_id, :cla_student_id, :cla_facilitator_id, :cla_course_id, :cla_cohort_id, :download_link)
      end

      def set_assignment
        @assignment = ClaAssignment.find(params[:cla_assignment_id])
      end
    end
  end
end
