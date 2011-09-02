module WorkoutAttendeesHelper

  def create_levels
    (10..100).step(10).collect {|val| ["#{val}%", val]}
  end

  def current_user?(workout_attendee)
    current_user == workout_attendee.user
  end

  def get_new_val(workout_attendee, val)
    return 0 if val == 0
    workout_attendee.likelihood + val
  end

  def get_change_type(val)
    return "X" if val == 0
    (val > 0) ? "+" : "-"
  end
end
