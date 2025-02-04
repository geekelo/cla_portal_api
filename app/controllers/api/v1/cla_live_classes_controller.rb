module API
  module V1
    class ClaLiveClassesController < ApplicationController
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
        params.require(:live_class).permit(:name, :date, :time, :duration, :zoom_link, :cla_course_id)
      end
    end
  end
end
