class CalendarController < ApplicationController
  before_filter :authenticate_user!

  # GET /calendar
  def index
    # Get workouts ranging from 3 days ago to 10 days in advance => 2 week window.
    # TODO: User should be select calendar mode - fixed 2 weeks, month, week etc.
    # TODO: User should be able to navigate forwards and backwards weeks
    first = 3.day.ago(Date.today)
    last = 10.day.from_now(Date.today)
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
  end
end
