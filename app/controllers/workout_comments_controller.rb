class WorkoutCommentsController < ApplicationController
  before_filter :authenticate_user!

  # POST /workouts/1/workout_comments
  def create
    @workout = Workout.find(params[:workout_id])
    @workout_comment = @workout.workout_comments.build(params[:workout_comment])
    @workout_comment.user = current_user

    if @workout_comment.save
      redirect_to(@workout, :notice => 'Comment was successfully saved.')
    else
      redirect_to(@workout, :notice => 'Failed to save comment.')
    end
  end

end
