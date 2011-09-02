class WorkoutAttendee < ActiveRecord::Base
  validates :likelihood, :numericality => { :greater_than => 0, :less_than_or_equal_to => 100 }, :presence => true
  validates_uniqueness_of :user_id, :scope => :workout_id

  belongs_to :user
  belongs_to :workout

  attr_accessible :likelihood, :user, :workout
end
