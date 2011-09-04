class WorkoutsController < ApplicationController
  before_filter :authenticate_user!

  # GET /workouts
  def index
    redirect_to :controller => "calendar", :action => "index"
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

    if @workout.update_attributes(params[:workout])
      redirect_to(@workout, :notice => 'Workout was successfully updated.')
    else
      render :action => "edit"
    end
  end

  # DELETE /workouts/1
  def destroy
    @workout = get_workout
    @workout.destroy

    redirect_to(workouts_url)
  end

  def get_workout
    begin
      # Moderators can update all workouts, otherwise users can only update the ones they've created
      if current_user.is_moderator?
        return Workouts.find(params[:id])
      else
        return current_user.workouts.find(params[:id])
      end
    rescue
      flash[:notice] = 'Cannot update workout, it does not exist or you did not create it.'
      redirect_to :back
    end
  end
end
