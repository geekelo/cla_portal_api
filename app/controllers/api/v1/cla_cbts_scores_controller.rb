class Api::V1::ClaCbtsScoresController < ApplicationController
  before_action :set_cbt, only: [:create]

  def index
    cbts_scores = if params[:cla_user_id].present?
      ClaCbtsScore.where(cla_user_id: params[:cla_user_id])
    elsif params[:cla_cbt_id].present?
      ClaCbtsScore.where(cla_cbt_id: params[:cla_cbt_id])
    elsif params[:cla_cohort_id].present?
      ClaCbtsScore.where(cla_cohort_id: params[:cla_cohort_id])
    else
      ClaCbtsScore.all
    end
    render json: cbts_scores, each_serializer: ClaCbtsScoreSerializer, status: :ok
  end

  def create
    cbt_score = @cbt.cla_cbts_scores.new(cbt_score_params)
    if cbt_score.save
      render json: cbt_score, each_serializer: ClaCbtsScoreSerializer, status: :created
    else
      render json: { errors: cbt_score.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    cbt_score = ClaCbtsScore.find(params[:id])
    if cbt_score.update(cbt_score_params)
      render json: cbt_score, each_serializer: ClaCbtsScoreSerializer, status: :ok
    else
      render json: { errors: cbt_score.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def students_without_scores
    # get all students in the cohort
    cohort = @cbt.cla_course.cla_cohort
    return render json: { error: 'CBT not found or has no associated cohort' }, status: :not_found unless cohort
    
    students = cohort.cla_users
    # get all students with scores
    student_ids_with_scores = ClaCbtsScore.where(cla_cbt_id: @cbt.id).pluck(:cla_user_id)
    # get all students without scores
    students_without_scores = students.where.not(user_id: student_ids_with_scores)
    
    # Add debugging information
    render json: {
      total_students_in_cohort: students.count,
      students_with_scores: student_ids_with_scores.count,
      students_without_scores: students_without_scores.count,
      cohort_id: cohort.id,
      cbt_id: @cbt.id,
      students_without_scores_list: ActiveModel::Serializer::CollectionSerializer.new(students_without_scores, each_serializer: ClaUserSerializer).as_json
    }, status: :ok
  end

  private

  def cbt_score_params
    params.require(:cla_cbts_score).permit(:cla_user_id, :cla_cbt_id, :cla_cohort_id, :score)
  end

  def set_cbt
    @cbt = ClaCbt.find(params[:cla_cbts_id])
  end
end
