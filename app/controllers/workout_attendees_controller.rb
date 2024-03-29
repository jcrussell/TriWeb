class WorkoutAttendeesController < ApplicationController
  before_filter :authenticate_user!

  helper_method :current_user?, :get_change_type

  # POST /workouts/1/workout_attendees
  def create
    @workout = Workout.find(params[:workout_id])
    @workout_attendee = @workout.workout_attendees.build(params[:workout_attendee])
    @workout_attendee.user = current_user

    if @workout_attendee.save
      redirect_to(@workout, :notice => 'Workout attendance was saved successfully.')
    else
      redirect_to(@workout, :alert => 'Failed to save workout attendance.')
    end
  end

  # PUT /workouts/1/workout_attendees
  def update
    @workout = Workout.find(params[:workout_id])
    @workout_attendee = @workout.workout_attendees.select { |workout_attendee| workout_attendee.user == current_user }.first

    if @workout_attendee.nil?
      redirect_to(@workout)
    elsif params[:workout_attendee][:likelihood].to_i == 0
      @workout_attendee.destroy
      redirect_to(@workout, :notice => 'Workout attendance was removed successfully.')
    elsif @workout_attendee.update_attributes(params[:workout_attendee])
      redirect_to(@workout, :notice => 'Workout attendance was updated successfully.')
    else
      redirect_to(@workout, :alert => 'Failed to update workout attendance.')
    end
  end

  protected

  def get_change_type(val)
    return "X" if val == 0
    (val > 0) ? "+" : "-"
  end
end
