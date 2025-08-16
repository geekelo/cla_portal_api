class Api::V1::ClaContributionsController < ApplicationController
  before_action :authenticate_user!

  def index
    contributions = if params[:cla_course_id].present?
                      ClaContribution.where(cla_course_id: params[:cla_course_id])
                    else
                      ClaContribution.where(cla_cohort_id: params[:cla_cohort_id])
                    end.order(created_at: :desc)

    render json: contributions, each_serializer: ClaContributionsSerializer, status: :ok
  end

  def show
    contribution = ClaContribution.find(params[:id])
    render json: contribution, each_serializer: ClaContributionsSerializer, status: :ok
  end

  def create
    contribution = ClaContribution.new(contribution_params)
    if contribution.save
      render json: contribution, each_serializer: ClaContributionsSerializer, status: :created
    else
      render json: { errors: contribution.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    contribution = ClaContribution.find(params[:id])
    if contribution.update(contribution_params)
      render json: contribution, each_serializer: ClaContributionsSerializer, status: :ok
    else
      render json: { errors: contribution.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    contribution = ClaContribution.find(params[:id])
    contribution.destroy
    if contribution.destroyed?
      render json: { message: 'Contribution deleted successfully' }, status: :ok
    else
      render json: { errors: contribution.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def contribution_params
    params.require(:cla_contribution).permit(:cla_course_id, :cla_user_id, :cla_cohort_id, :name, :description, :due_date)
  end
end
