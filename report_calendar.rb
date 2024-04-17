# ReportCalendar is the usefull app for trecking your report deadlines.

class ReportCalendar
  def closest_report
    # code
  end

  def today_date
    time = Time.new
    time = time.to_a
    today = time[3..5]
  end
end

a = ReportCalendar.new
puts a.today_date
