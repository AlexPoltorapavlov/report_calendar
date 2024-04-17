require 'date'
require 'holidays'

# ReportCalendar is the usefull app for trecking your report deadlines.
class ReportCalendar
  def closest_report
    # code
  end

  def today_date
    Date.today
  end

  def add_weekdays(date, days)
    while days > 0
      date = date + 1
      unless date.saturday? || date.sunday? || Holidays.on(date, :ru).any?
        p date
        days -= 1
      end
    end
    date
  end

end

a = ReportCalendar.new
b = a.today_date
puts a.add_weekdays(b, 10)
