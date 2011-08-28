class Workout < ActiveRecord::Base
  attr_accessible :when, :description, :what, :when

  # Returns a list of hashes between first and last. In the hash, there are two keys,
  # :date, and :workouts.
  # Expects two dates for parameters
  def self.find_by_range(first, last)
    found = Workout.find(:all, :conditions => {:when => (first..last)})
    workouts = []

    (first..last).each do |day|
      workouts << {:date =>day, :workouts => found.select {|x| x.when.to_date == day} }
    end

    workouts
  end
end
