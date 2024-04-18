# frozen_string_literal: true

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

require "date"
require "net/http"

# ReportCalendar is the usefull app for trecking your report deadlines.
class ReportCalendar
  def initialize
    @current_calendar = update_info
  end

  def closest_report
    # code
  end

  def monthly_report_weekdays
    date = today_date

    next_month = date.month == 12 ? 1 : date.month + 1
    year = date.month == 12 ? date.year + 1 : date.year

    report_day = Date.new(year, next_month, 1)

    report_day = add_weekdays(report_day, 10)

    remaining_days = (report_day - date).to_i

    [report_day, " - месячный отчет по рабочим дням. Осталось дней: ", remaining_days]
  end

  def workday?(date)
    @current_calendar[date]
  end

  def today_date
    Date.today
  end

  def update_info(year = today_date.year)
    uri = URI("https://isdayoff.ru/api/getdata?year=#{year}")
    workdays = Net::HTTP.get(uri)
    dates = (Date.new(year)..Date.new(year, -1, -1)).to_a
    Hash[dates.zip(workdays.chars)]
  end

  def add_weekdays(date, days)
    while days.positive?
      date += 1
      days -= 1 if workday?(date) == "0"
    end
    date
  end
end

a = ReportCalendar.new
puts a.monthly_report_weekdays
