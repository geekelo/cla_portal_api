class Api::V1::ClaContributionsScoresController < ApplicationController
  def index
    contributions_scores = ClaContributionsScore.all
    render json: contributions_scores, each_serializer: ClaContributionsScoreSerializer, status: :ok
  end

  def create
    contributions_score = @contribution.cla_contributions_scores.new(contributions_score_params)
    if contributions_score.save
      render json: contributions_score, each_serializer: ClaContributionsScoreSerializer, status: :created
    else
      render json: { errors: contributions_score.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    contributions_score = ClaContributionsScore.find(params[:id])
    if contributions_score.update(contributions_score_params)
      render json: contributions_score, each_serializer: ClaContributionsScoreSerializer, status: :ok
    else
      render json: { errors: contributions_score.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def contributions_score_params
    params.require(:cla_contributions_score).permit(:cla_contribution_id, :cla_user_id, :cla_cohort_id, :score)
  end

  def set_contribution
    @contribution = ClaContribution.find(params[:cla_contribution_id])
  end
end
