class WorkoutsController < ApplicationController
  before_filter :authenticate_user!

  # GET /workouts
  def index
    redirect_to calendar_index_path
  end

  # GET /workouts/1
  def show
    @workout = Workout.find(params[:id])
  end

  # GET /workouts/new
  def new
    @workout = Workout.new
  end

  # GET /workouts/1/edit
  def edit
    @workout = get_workout

    if @workout.nil?
      redirect_to(:back, :alert => 'Cannot edit workout, it does not exist or you did not create it.')
    end
  end

  # POST /workouts
  def create
    @workout = current_user.workouts.build(params[:workout])

    if @workout.save
      redirect_to(@workout, :notice => 'Workout was successfully created.')
    else
      render :action => "new"
    end
  end

  # PUT /workouts/1
  def update
    @workout = get_workout

    if @workout.nil?
      redirect_to(:back, :alert => 'Cannot update workout, it does not exist or you did not create it.')
    elsif @workout.update_attributes(params[:workout])
      redirect_to(@workout, :notice => 'Workout was successfully updated.')
    else
      render :action => "edit"
    end
  end

  # DELETE /workouts/1
  def destroy
    @workout = get_workout

    if @workout.nil?
      redirect_to(:back, :alert => 'Cannot destroy workout, it does not exist or you did not create it.')
    else
      @workout.destroy
      redirect_to(workouts_url, :notice => 'Workout removed successfully')
    end
  end

  private

  def get_workout
    begin
      # Moderators can update all workouts, otherwise users can only update the ones they've created
      if current_user.is_moderator?
        Workout.find(params[:id])
      else
        current_user.workouts.find(params[:id])
      end
    rescue ActiveRecord::RecordNotFound
      nil
    end
  end
end
