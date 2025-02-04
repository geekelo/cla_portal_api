module API
  module V1
    class ClaTopicsController < ApplicationController
      def create
        topic = ClaTopic.new(topic_params)
        if topic.save
          render json: { message: 'Topic created successfully' }, status: :created
        else
          render json: { error: 'Something went wrong creating topic' }, status: :unprocessable_entity
        end
      end

      def update
        topic = ClaTopic.find(params[:id])
        if topic.update(topic_params)
          render json: { message: 'Topic updated successfully' }, status: :ok
        else
          render json: { error: 'Something went wrong updating topic' }, status: :unprocessable_entity
        end
      end

      def destroy
        topic = ClaTopic.find(params[:id])
        topic.destroy
        render json: { message: 'Topic deleted successfully' }, status: :ok
      end

      private

      def topic_params
        params.require(:topic).permit(:name, :description, :cla_course_id) 
      end
    end
  end
end
