class Workout < ActiveRecord::Base
  TYPES = %w(Swim Bike Run Brick Race Social Other)

  validates :name, :description, :what, :time, :presence => true
  validates_inclusion_of :what, :in => TYPES
  validates_datetime :time, :after => :now

  attr_accessible :name, :description, :what, :time

  has_many :workout_attendees, :dependent => :destroy

  belongs_to :user # user that created the workout

  # Returns a list of hashes between first and last. In the hash, there are two keys,
  # :date, and :workouts.
  # Expects two dates for parameters
  def self.find_by_range(first, last)
    found = Workout.find(:all, :conditions => {:time => (first..last)}, :order => "time")
    workouts = []

    (first..last).each do |day|
      workouts << {:date => day, :workouts => found.select {|x| x.time.to_date == day} }
    end

    workouts
  end
end
