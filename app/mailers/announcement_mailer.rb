class AnnouncementMailer < ApplicationMailer
  def new_announcement(announcement, students)
    @announcement = announcement
    @students = students
    
    # Send to all students in the cohort
    @students.each do |student|
      mail(
        to: student.email,
        subject: "New Announcement: #{@announcement.title}",
        from: 'JJRSF CLA Moodle'
      )
    end
  end

  def score_email(user, score_type, score = nil)
    @user = user
    @score_type = score_type
    @score = score
    mail(
      to: @user.email,
      subject: "Your #{@score_type} has been updated",
      from: 'JJRSF CLA Moodle'
    )
  end
end
