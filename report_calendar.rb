# Вам нужно сдавать отчётность. И вы хотели бы знать сколько дней осталось до следующей сдачи. Есть несколько типов
# отчетности:
#
# - месячная - сдается в течении 10 рабочих дней
# - квартальная (март, июнь, сентябрь) - сдается в течении 10 рабочих дней
# - квартальная (март, июнь, сентябрь) - сдается в течении 30 календарных дней
# - годовая - сдается в течении 10 рабочих дней
# - годовая - сдается в течении 30 календарных дней
#
# Первый день сдачи - это начало следующего месяца. Нужно создать программу, которая возвращает крайний день сдачи
# отчетности, и сколько дней осталось до этой даты относительно текущего времени, тип отчетности.

require 'date'
require 'net/http'

# ReportCalendar is the usefull app for trecking your report deadlines.
class ReportCalendar
  def closest_report
    # code
  end

  def monthly_report
    date = self.today_date
    current_month_report_day = Date.new(date.year, date.month, 1)
    current_month_report_day = self.add_weekdays(current_month_report_day, 10)

    return current_month_report_day if date <= current_month_report_day

    next_month_report_day = Date.new(date.year, date.month + 1, 1)
    if date.month == 12
      next_month_report_day = Date.new(date.year, 1, 1)
    end

    next_month_report_day = self.add_weekdays(next_month_report_day, 10)
    next_month_report_day
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
puts a.monthly_report
