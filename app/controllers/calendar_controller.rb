class CalendarController < ApplicationController
  before_filter :authenticate_user!

  # GET /calendar
  # GET /calendar?date=YYYY-MM-DD
  def index
    @date = Date.parse(params[:date]) unless params[:date].nil?
    @date ||= Date.today

    # Get workouts ranging from 3 days ago to 10 days in advance => 2 week window.
    # TODO: User should be able to select calendar mode - fixed 2 weeks, month, week etc.
    first = 3.day.ago(@date)
    last = 10.day.from_now(@date)

    @workouts = Workout.find_by_range(first, last)

    # Add class to each: past, today, future
    @workouts.each do |hash|
      if hash[:date].today?
        hash[:class] = "today"
      elsif hash[:date].past?
        hash[:class] = "past"
      else
        hash[:class] = "future"
      end
    end

    # Sort the days into weeks
    @workouts = @workouts.in_groups_of(7)

    days = %w(Sunday Monday Tuesday Wednesday Thursday Friday Saturday)
    # Get the list of days of the week, only need the first 7
    @days_of_week = (first..last).collect {|x| days[x.wday]}.uniq

    # Calendar navigation
    @next_group = 14.days.from_now(@date)
    @prev_group = 14.days.ago(@date)
  end
end
