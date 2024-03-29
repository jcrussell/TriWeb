class WorkoutCommentsController < ApplicationController
  before_filter :authenticate_user!

  helper_method :current_user?

  # POST /workouts/1/workout_comments
  def create
    @workout = Workout.find(params[:workout_id])
    @workout_comment = @workout.workout_comments.build(params[:workout_comment])
    @workout_comment.user = current_user

    if @workout_comment.save
      redirect_to(@workout, :notice => 'Comment was saved successfully.')
    else
      redirect_to(@workout, :alert => 'Failed to save comment.')
    end
  end

  protected

  def current_user?(workout)
    workout.user == current_user
  end
end
