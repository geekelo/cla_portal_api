module Api
  module V1
    class ClaCoursesController < ApplicationController
      def index
        courses = ClaCourse.all
        render json: courses, each_serializer: ClaCourseSerializer, status: :ok
      end

      def show
        course = ClaCourse.find(params[:id])
        render json: { course: course }, status: :ok
      end

      def create
        course = ClaCourse.new(course_params)
        if course.save
          render json: { message: 'Course created successfully' }, status: :created
        else
          render json: { error: 'Something went wrong creating course' }, status: :unprocessable_entity
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

      private

      def course_params
        params.require(:course).permit(:name, :description, :cla_cohort_id, :start_date, :end_date, :cla_user_id)
      end
    end
  end
end
