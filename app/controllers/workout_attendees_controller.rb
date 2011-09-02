class WorkoutAttendeesController < ApplicationController
  before_filter :authenticate_user!

  # GET /workouts/1/workout_attendees/new
  def new
    @workout = Workout.find(params[:workout_id])
    @workout_attendee = @workout.workout_attendees.build
  end

  # GET /workouts/1/workout_attendees/1/edit
  def edit
    @workout = Workout.find(params[:workout_id])
    @workout_attendee = find_attendance_for_user
  end

  # POST /workouts/1/workout_attendees
  def create
    @workout = Workout.find(params[:workout_id])
    @workout_attendee = @workout.workout_attendees.build(params[:workout_attendee])
    @workout_attendee.user = current_user

    if @workout_attendee.save
      redirect_to(@workout, :notice => 'Workout attendance was successfully saved.')
    else
      redirect_to(@workout, :notice => 'Failed to save workout attendance.')
    end
  end

  # PUT /workouts/1/workout_attendees
  def update
    @workout = Workout.find(params[:workout_id])
    @workout_attendee = find_attendance_for_user

    if params[:workout_attendee][:likelihood] == "0"
      @workout_attendee.destroy
      redirect_to(@workout, :notice => 'Workout attendance removed successfully.')
    elsif @workout_attendee.update_attributes(params[:workout_attendee])
      redirect_to(@workout, :notice => 'Workout attendance was successfully updated.')
    else
      redirect_to(@workout, :notice => 'Failed to update workout attendance.')
    end
  end

  private

  def find_attendance_for_user()
    match = @workout.workout_attendees.select { |workout_attendee| workout_attendee.user == current_user }
    if match.empty?
      redirect_to(@workout)
    else
      match[0]
    end
  end
end
