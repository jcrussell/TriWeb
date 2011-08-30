class WorkoutsController < ApplicationController
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
    @workout = Workout.find(params[:id])
  end

  # POST /workouts
  def create
    @workout = Workout.new(params[:workout])

    if @workout.save
      redirect_to(@workout, :notice => 'Workout was successfully created.')
    else
      render :action => "new"
    end
  end

  # PUT /workouts/1
  def update
    @workout = Workout.find(params[:id])

    if @workout.update_attributes(params[:workout])
      redirect_to(@workout, :notice => 'Workout was successfully updated.')
    else
      render :action => "edit"
    end
  end

  # DELETE /workouts/1
  def destroy
    @workout = Workout.find(params[:id])
    @workout.destroy

    redirect_to(workouts_url)
  end
end
