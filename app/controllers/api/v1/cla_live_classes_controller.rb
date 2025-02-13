module Api
  module V1
    class ClaLiveClassesController < ApplicationController
      def index
        if params[:filter_id].present?
          submissions = ClaLiveClass.where("cla_cohort_id = ? OR cla_course_id = ? OR cla_user_id = ?", params[:filter_id], params[:filter_id], params[:filter_id])
        else
          submissions = ClaLiveClass.all
        end
      
        render json: submissions, each_serializer:ClaLiveClassSerializer, status: :ok
      end      
      
      def create
        live_class = ClaLiveClass.new(live_class_params)
        if live_class.save
          render json: { message: 'Live class created successfully' }, status: :created
        else
          render json: { error: 'Something went wrong creating live class' }, status: :unprocessable_entity
        end
      end

      def update
        live_class = ClaLiveClass.find(params[:id])
        if live_class.update(live_class_params)
          render json: { message: 'Live class updated successfully' }, status: :ok
        else
          render json: { error: 'Something went wrong updating live class' }, status: :unprocessable_entity
        end
      end

      def destroy
        live_class = ClaLiveClass.find(params[:id])
        live_class.destroy
        render json: { message: 'Live class deleted successfully' }, status: :ok
      end

      private

      def live_class_params
        params.require(:cla_live_class).permit(:name, :date, :time, :duration, :zoom_link, :cla_course_id, :cla_cohort_id, :cla_user_id)
      end
    end
  end
end
