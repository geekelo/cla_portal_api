module ClaDashboardAttendanceStatsHelper
  def self.user_attendance_percentage(user_id, course_id)
    total_classes = ClaAttendance.where(cla_user_id: user_id, cla_course_id: course_id).count
    total_present = ClaAttendance.where(cla_user_id: user_id, cla_course_id: course_id, present: true).count

    attendance_percentage = total_classes.zero? ? 0 : (total_present.to_f / total_classes * 100).round(2)
    attendance_points = ((attendance_percentage * 30)/100).round(2)

    {
      user_id:,
      total_classes:,
      total_present:,
      attendance_percentage:,
      attendance_points:
    }
  end
end
