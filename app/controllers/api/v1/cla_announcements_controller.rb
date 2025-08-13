class Api::V1::ClaAnnouncementsController < ApplicationController
  before_action :authenticate_user!

  def index
    announcements = if current_user.cla_role.name == 'facilitator'
                      ClaAnnouncement.where(cla_cohort_id: params[:cla_cohort_id]).sort_by(&:created_at).reverse
                    else
                      cohortNotices = ClaAnnouncement.where(cla_cohort_id: params[:cla_cohort_id])
                      userNotices = ClaAnnouncement.where(cla_user_id: current_user.id)
                      (cohortNotices + userNotices).sort_by(&:created_at).reverse
                    end
    render json: announcements, each_serializer: ClaAnnouncementSerializer
  end

  def create
    announcement = ClaAnnouncement.new(announcement_params)
    if announcement.save
      # Send email notifications to students
      send_announcement_emails(announcement)
      
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

  def send_announcement_emails(announcement)
    if announcement.cla_cohort_id
      if announcement.cla_user_id
        # Send to specific user
        student = ClaUser.find_by(user_id: announcement.cla_user_id)
        AnnouncementMailer.new_announcement(announcement, [student]).deliver_now if student
      else
        # Send to all students in the cohort
        students = ClaUser.where(cla_cohort_id: announcement.cla_cohort_id)
        AnnouncementMailer.new_announcement(announcement, students).deliver_now if students.any?
      end
    end
  end
end
