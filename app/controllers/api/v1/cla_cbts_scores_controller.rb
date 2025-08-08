class Api::V1::ClaCbtsScoresController < ApplicationController
  before_action :set_cbt, only: [:create]

  def index
    cbts_scores = if params[:cla_user_id].present?
      ClaCbtScore.where(cla_user_id: params[:cla_user_id])
    elsif params[:cla_cbt_id].present?
      ClaCbtScore.where(cla_cbt_id: params[:cla_cbt_id])
    elsif params[:cla_cohort_id].present?
      ClaCbtScore.where(cla_cohort_id: params[:cla_cohort_id])
    else
      ClaCbtScore.all
    end
    render json: cbts_scores, each_serializer: ClaCbtScoreSerializer, status: :ok
  end

  def create
    cbt_score = @cbt.cla_cbts_scores.new(cbt_score_params)
    if cbt_score.save
      render json: cbt_score, each_serializer: ClaCbtScoreSerializer, status: :created
    else
      render json: { errors: cbt_score.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    cbt_score = ClaCbtScore.find(params[:id])
    if cbt_score.update(cbt_score_params)
      render json: cbt_score, each_serializer: ClaCbtScoreSerializer, status: :ok
    else
      render json: { errors: cbt_score.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def cbt_score_params
    params.require(:cla_cbts_score).permit(:cla_user_id, :cla_cbt_id, :cla_cohort_id, :score)
  end

  def set_cbt
    @cbt = ClaCbt.find(params[:cla_cbts_id])
  end
end
