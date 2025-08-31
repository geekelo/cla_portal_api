class Api::V1::ClaContributionsScoresController < ApplicationController
  before_action :set_contribution, only: [:create, :students_without_scores]
  
  def index
    contributions_scores = ClaContributionsScore.all
    render json: contributions_scores, each_serializer: ClaContributionsScoreSerializer, status: :ok
  end

  def create
    # Find existing score or initialize a new one
    contributions_score = ClaContributionsScore.find_or_initialize_by(
      cla_contribution_id: contributions_score_params[:cla_contribution_id],
      cla_user_id: contributions_score_params[:cla_user_id],
      cla_cohort_id: contributions_score_params[:cla_cohort_id]
    )
    
    # Update the score
    contributions_score.score = contributions_score_params[:score]
    
    if contributions_score.save
      # send email to student
      AnnouncementMailer.score_email(contributions_score.cla_user, 'Contribution Score', contributions_score).deliver_now
      status = contributions_score.previously_new_record? ? :created : :ok
      message = contributions_score.previously_new_record? ? 'Contribution score created successfully' : 'Contribution score updated successfully'
      render json: { message: message }, status: status
    else
      render json: { errors: contributions_score.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    contributions_score = ClaContributionsScore.find(params[:id])
    if contributions_score.update(contributions_score_params)
      render json: { message: 'Contribution score updated successfully' }, status: :ok
    else
      render json: { errors: contributions_score.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def students_without_scores
    # get all students in the cohort
    cohort = @contribution.cla_course.cla_cohort
    return render json: { error: 'Contribution not found or has no associated cohort' }, status: :not_found unless cohort
    
    students = cohort.cla_users
    # get all students with scores
    student_ids_with_scores = ClaContributionsScore.where(cla_contribution_id: @contribution.id).pluck(:cla_user_id)
    # get all students without scores
    students_without_scores = students.where.not(user_id: student_ids_with_scores)
    
    # Add debugging information
    render json: {
      total_students_in_cohort: students.count,
      students_with_scores: student_ids_with_scores.count,
      students_without_scores: students_without_scores.count,
      cohort_id: cohort.id,
      contribution_id: @contribution.id,
      students_without_scores_list: ActiveModel::Serializer::CollectionSerializer.new(students_without_scores, each_serializer: ClaUserSerializer).as_json
    }, status: :ok
  end

  private

  def contributions_score_params
    params.require(:cla_contributions_score).permit(:cla_contribution_id, :cla_user_id, :cla_cohort_id, :score)
  end

  def set_contribution
    @contribution = ClaContribution.find(params[:cla_contribution_id])
  end
end
