class Api::V1::ClaContributionsController < ApplicationController
  def index
    contributions = if params[:cla_user_id].present?
                      ClaContribution.where(cla_user_id: params[:cla_user_id])
                    elsif params[:cla_cohort_id].present?
                      ClaContribution.where(cla_cohort_id: params[:cla_cohort_id])
                    else
                      ClaContribution.all
                    end.order(created_at: :asc)

    render json: contributions, each_serializer: ClaContributionSerializer, status: :ok
  end

  def show
    contribution = ClaContribution.find(params[:id])
    render json: contribution, each_serializer: ClaContributionSerializer, status: :ok
  end

  def create
    contribution = ClaContribution.new(contribution_params)
    if contribution.save
      render json: contribution, each_serializer: ClaContributionSerializer, status: :created
    else
      render json: { errors: contribution.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    contribution = ClaContribution.find(params[:id])
    if contribution.update(contribution_params)
      render json: contribution, each_serializer: ClaContributionSerializer, status: :ok
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
