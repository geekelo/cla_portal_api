module Api
  module V1
    class ClaTopicsController < ApplicationController
      def index
        topics = if params[:cla_course_id].present?
                   ClaTopic.where(cla_course_id: params[:cla_course_id])
                 else
                   ClaTopic.all
                 end.order(created_at: :asc) # or :asc for oldest first
      
        render json: topics, each_serializer: ClaTopicSerializer, status: :ok
      end      

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
