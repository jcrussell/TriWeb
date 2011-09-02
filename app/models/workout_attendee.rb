class WorkoutAttendee < ActiveRecord::Base
  validates :likelihood, :numericality => { :greater_than => 0, :less_than_or_equal_to => 100 }, :presence => true

  belongs_to :user
  belongs_to :workout

  attr_accessible :likelihood
end
