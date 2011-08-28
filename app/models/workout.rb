class Workout < ActiveRecord::Base
  attr_accessible :when, :description, :what, :when

  # Returns a hash where the keys are the days between first and last and the values
  # are arrays of the workouts on that day
  def self.find_by_range(first, last)
    # Make sure we're dealing with dates
    first = first.to_date
    last = last.to_date
    found = Workout.find(:all, :conditions => {:when => (first..last)})
    workouts = {}

    (first..last).each do |day|
      workouts[day] = found.select {|x| x.when.to_date == day}
    end

    workouts
  end
end
