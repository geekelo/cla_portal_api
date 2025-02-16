module ClaDashboardAttendanceStatsHelper
  def user_attendance_percentage(user_id)
    total_classes = ClaAttendance.where(cla_user_id: user_id).count
    total_present = ClaAttendance.where(cla_user_id: user_id, present: true).count

    attendance_percentage = total_classes.zero? ? 0 : (total_present.to_f / total_classes * 100).round(2)

    {
      user_id: user_id,
      total_classes: total_classes,
      total_present: total_present,
      attendance_percentage: attendance_percentage
    }
  end
end
