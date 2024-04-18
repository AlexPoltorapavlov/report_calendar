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

  def annual_report_weekdays
    date = today_date
    year = date.month == 1 ? date.year : date.year + 1
    report_day = Date.new(year, 1, 1)
    report_day = add_weekdays(report_day)
    return report_day if (report_day - date).positive?

    add_weekdays(Date.new(year + 1, 1, 1))
  end

  def annual_report
    date = today_date
    year = date.month == 1 && date.day != 31 ? date.year : date.year + 1
    Date.new(year, 1, 30)
  end

  def quarterly_report_day
    date = today_date
    months_for_report = [Date.new(date.year, 4, 30), Date.new(date.year, 7, 30), Date.new(date.year, 10, 30)]
    months_for_report.each do |report_day|
      return report_day if (report_day - date).positive?
    end
  end

  def quarterly_report_weekdays
    date = today_date
    months_for_report = [Date.new(date.year, 4, 1), Date.new(date.year, 7, 1), Date.new(date.year, 10, 1)]
    months_for_report = months_for_report.map do |report_day|
      add_weekdays(report_day)
    end

    months_for_report.each do |report_day|
      return report_day if (report_day - date).positive?
    end
  end

  def monthly_report
    date = today_date
    next_month = date.month == 12 ? 1 : date.month + 1
    year = date.month == 12 ? date.year + 1 : date.year
    current_month_report = add_weekdays(Date.new(date.year, date.month, 1))
    return current_month_report unless (date - current_month_report).to_i.positive?

    add_weekdays(Date.new(year, next_month, 1))
  end

  def workday?(date)
    @current_calendar[date]
  end

  def today_date
    Date.today
  end

  def update_info(year = today_date.year)
    uri1 = URI("https://isdayoff.ru/api/getdata?year=#{year}")
    uri2 = URI("https://isdayoff.ru/api/getdata?year=#{year + 1}")
    workdays_current_year = Net::HTTP.get(uri1)
    workdays_next_year = Net::HTTP.get(uri2)
    workdays = workdays_current_year + workdays_next_year
    dates = (Date.new(year)..Date.new(year + 1, -1, -1)).to_a
    Hash[dates.zip(workdays.chars)]
  end

  def add_weekdays(date, days = 10)
    while days.positive?
      date += 1
      days -= 1 if workday?(date) == "0"
    end
    date
  end
end

a = ReportCalendar.new
puts a.annual_report_weekdays
