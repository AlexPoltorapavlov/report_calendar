require 'date'
require 'net/http'

# ReportCalendar is the usefull app for trecking your report deadlines.
class ReportCalendar
  def closest_report
    # code
  end

  def workday?(date)
    date = date.to_s
    date = date.gsub(/\D/, '')
    source = Net::HTTP.get('isdayoff.ru', "/#{date}")
  end

  def today_date
    date = Date.today
  end

  def add_weekdays(date, days)
    while days > 0
      date = date + 1
      if self.workday?(date) == "0"
        days -= 1
      end
    end
    date
  end

end

a = ReportCalendar.new
puts a.add_weekdays(a.today_date, 10)
