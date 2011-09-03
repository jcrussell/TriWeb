module WorkoutCommentsHelper

  def current_user?(workout_comment)
    current_user == workout_comment.user
  end
end
