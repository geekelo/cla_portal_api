class Api::V1::ClaCbtsController < ApplicationController
  def index
    cbts = if params[:cla_user_id].present?
             ClaCbt.where(cla_user_id: params[:cla_user_id])
           elsif params[:cla_cohort_id].present?
             ClaCbt.where(cla_cohort_id: params[:cla_cohort_id])
           else
             ClaCbt.all
           end.order(created_at: :asc)

    render json: cbts, each_serializer: ClaCbtSerializer, status: :ok
  end

  def show
    cbt = ClaCbt.find(params[:id])
    render json: cbt, each_serializer: ClaCbtSerializer, status: :ok
  end

  def create
    cbt = ClaCbt.new(cbt_params)
    if cbt.save
      render json: cbt, each_serializer: ClaCbtSerializer, status: :created
    else
      render json: { errors: cbt.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    cbt = ClaCbt.find(params[:id])
    if cbt.update(cbt_params)
      render json: cbt, each_serializer: ClaCbtSerializer, status: :ok
    else
      render json: { errors: cbt.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    cbt = ClaCbt.find(params[:id])
    cbt.destroy
    if cbt.destroyed?
      render json: { message: 'CBT deleted successfully' }, status: :ok
    else
      render json: { errors: cbt.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def cbt_params
    params.require(:cla_cbt).permit(:cla_course_id, :cla_user_id, :cla_cohort_id, :name, :description, :due_date, :url)
  end
end

