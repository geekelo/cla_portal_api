class AnnouncementMailer < ApplicationMailer
  def new_announcement(announcement, students)
    @announcement = announcement
    @students = students
    
    # Send to all students in the cohort
    @students.each do |student|
      mail(
        to: student.email,
        subject: "New Announcement: #{@announcement.title}",
        from: 'jjrsfcla@gmail.com'
      )
    end
  end
end 