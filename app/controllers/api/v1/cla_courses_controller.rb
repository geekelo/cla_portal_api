module Api
  module V1
    class ClaCoursesController < ApplicationController
      def index
        courses = if params[:cla_user_id].present?
                    ClaCourse.where(cla_user_id: params[:cla_user_id])
                  elsif params[:cla_cohort_id].present?
                    ClaCourse.where(cla_cohort_id: params[:cla_cohort_id])
                  else
                    ClaCourse.all
                  end

        render json: courses, each_serializer: ClaCourseSerializer, status: :ok
      end

      def show
        course = ClaCourse.find(params[:id])
        render json: { course: }, status: :ok
      end

      def create
        course = ClaCourse.new(course_params)

        if course.save
          render json: course, status: :created
        else
          Rails.logger.info "Validation Errors: #{course.errors.full_messages}"
          render json: { errors: course.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        course = ClaCourse.find(params[:id])
        if course.update(course_params)
          render json: { message: 'Course updated successfully' }, status: :ok
        else
          render json: { error: 'Something went wrong updating course' }, status: :unprocessable_entity
        end
      end

      def destroy
        course = ClaCourse.find(params[:id])
        course.destroy
        render json: { message: 'Course deleted successfully' }, status: :ok
      end

      def get_course_ids
        course_ids = ClaCourse.where(cla_cohort_id: params[:cla_cohort_id]).pluck(:id)
        render json: { course_ids: }, status: :ok
      end

      private

      def course_params
        params.require(:cla_course).permit(:name, :description, :cla_cohort_id, :start_date, :end_date, :cla_user_id)
      end
    end
  end
end
