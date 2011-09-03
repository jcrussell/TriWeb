class WorkoutComment < ActiveRecord::Base
  validates :comment, :presence => true

  belongs_to :user
  belongs_to :workout

  attr_accessible :comment, :user, :workout
end
