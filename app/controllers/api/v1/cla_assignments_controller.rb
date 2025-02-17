module Api
  module V1
    class ClaAssignmentsController < ApplicationController
      def index
        assignments = if params[:cla_course_id].present?
                        ClaAssignment.where(cla_course_id: params[:cla_course_id])
                      elsif params[:cla_user_id].present?
                        ClaAssignment.where(cla_user_id: params[:cla_user_id])
                      else
                        ClaAssignment.all
                      end

        render json: assignments, each_serializer: ClaAssignmentSerializer, status: :ok
      end

      def create
        assignment = ClaAssignment.new(assignment_params)
        if assignment.save
          render json: { message: 'Assignment created successfully' }, status: :created
        else
          render json: { error: 'Something went wrong creating assignment' }, status: :unprocessable_entity
        end
      end

      def update
        assignment = ClaAssignment.find(params[:id])
        if assignment.update(assignment_params)
          render json: { message: 'Assignment updated successfully' }, status: :ok
        else
          render json: { error: 'Something went wrong updating assignment' }, status: :unprocessable_entity
        end
      end

      def destroy
        assignment = ClaAssignment.find(params[:id])
        assignment.destroy
        render json: { message: 'Assignment deleted successfully' }, status: :ok
      end

      private

      def assignment_params
        params.require(:cla_assignment).permit(:name, :description, :due_date, :cla_course_id, :cla_user_id)
      end
    end
  end
end
