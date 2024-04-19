# frozen_string_literal: true

require_relative "report_calendar"

calendar = ReportCalendar.new
p calendar.output_format(calendar.annual_report[0], calendar.annual_report[2])
