module WorkoutsHelper

  def marked_interest?(workout)
    workout.workout_attendees.exists?(:user_id  => current_user.id)
  end
end
