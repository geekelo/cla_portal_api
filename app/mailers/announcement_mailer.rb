class AnnouncementMailer < ApplicationMailer
  def send_new_announcement(announcement)
    @announcement = announcement
    
    # Send to all students in the cohort
    if announcement.cla_user_id
      student = ClaUser.find_by(user_id: announcement.cla_user_id)
      mail(
        to: student.email,
        subject: "New Announcement: #{@announcement.title}",
        from: 'jjrsfcla@gmail.com'
      )
    else
      students = ClaUser.where(cla_cohort_id: announcement.cla_cohort_id)
      students.each do |student|
        mail(
        to: student.email,
        subject: "New Announcement: #{@announcement.title}",
        from: 'jjrsfcla@gmail.com'
      )
    end
  end
end 