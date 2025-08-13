class Api::V1::ClaAnnouncementsController < ApplicationController
  before_action :authenticate_user!

  def index
    announcements = if current_user.cla_role.name == 'facilitator'
                      ClaAnnouncement.where(cla_cohort_id: current_user.cla_cohort_id)
                    else
                      cohortNotices = ClaAnnouncement.where(cla_cohort_id: params[:cla_cohort_id])
                      userNotices = ClaAnnouncement.where(cla_user_id: current_user.id)
                      cohortNotices + userNotices
                    end.order(created_at: :desc)
    render json: announcements, each_serializer: ClaAnnouncementSerializer
  end

  def create
    announcement = ClaAnnouncement.new(announcement_params)
    if announcement.save
      render json: announcement, status: :created
    else
      render json: announcement.errors, status: :unprocessable_entity
    end
  end

  def update
    announcement = ClaAnnouncement.find(params[:id])
    if announcement.update(announcement_params)
      render json: announcement, status: :ok
    else
      render json: announcement.errors, status: :unprocessable_entity
    end
  end

  def destroy
    announcement = ClaAnnouncement.find(params[:id])
    if announcement.destroy
      render json: { message: 'Announcement deleted successfully' }, status: :ok
    else
      render json: { message: 'Failed to delete announcement' }, status: :unprocessable_entity
    end
  end

  private

  def announcement_params
    params.require(:cla_announcement).permit(:title, :content, :cla_cohort_id, :cla_user_id)
  end
end
