module Api
  module V1
    class ClaCohortsController < ApplicationController
      def index
        cohorts = ClaCohort.all
        render json: { cohorts: }, status: :ok
      end

      def show
        cohort = ClaCohort.find(params[:id])
        render json: { cohort: }, status: :ok
      end

      def create
        cohort = ClaCohort.new(cohort_params)
        if cohort.save
          render json: { message: 'Cohort created successfully' }, status: :created
        else
          render json: { error: 'Something went wrong creating cohort' }, status: :unprocessable_entity
        end
      end

      def update
        cohort = ClaCohort.find(params[:id])
        if cohort.update(cohort_params)
          render json: { message: 'Cohort updated successfully' }, status: :ok
        else
          render json: { error: 'Something went wrong updating cohort' }, status: :unprocessable_entity
        end
      end

      def destroy
        cohort = ClaCohort.find(params[:id])
        cohort.destroy
        render json: { message: 'Cohort deleted successfully' }, status: :ok
      end

      def students_of_cohort
        cohort = ClaCohort.find(params[:cla_cohort_id])
        students = cohort.cla_users
        render json: { students: students.map { |student| { user_id: student.user_id, name: student.name } } }, status: :ok
      end

      private

      def cohort_params
        params.require(:cohort).permit(:name, :start_date, :end_date)
      end
    end
  end
end
