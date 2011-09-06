class WorkoutAttendee < ActiveRecord::Base
  validates :likelihood, :numericality => { :greater_than => 0, :less_than_or_equal_to => 100 }, :presence => true
  validates_uniqueness_of :user_id, :scope => :workout_id

  belongs_to :user
  belongs_to :workout

  attr_accessible :likelihood, :user, :workout

  # Likelihood can be from (0, 100] but these are the prefered levels that will be displayed for selection
  def self.prefered_levels
    (10..100).step(10).collect {|val| ["#{val}%", val]}
  end

  # zero => zero
  # non-zero => likelihood+val
  def get_new_val(val)
    return 0 if val == 0
    likelihood + val
  end
end
