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
    begin
      @workout = current_user.workouts.find(params[:id])
    rescue
      flash[:notice] = 'Cannot edit workout, it does not exist or you did not create it.'
      redirect_to :back
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
    begin
      # Can only update workouts that user created
      @workout = current_user.workouts.find(params[:id])

      if @workout.update_attributes(params[:workout])
        redirect_to(@workout, :notice => 'Workout was successfully updated.')
      else
        render :action => "edit"
      end
    rescue
      flash[:notice] = 'Cannot update workout, it does not exist or you did not create it.'
      redirect_to :back
    end
  end

  # DELETE /workouts/1
  def destroy
    begin
      # Can only destroy workouts that user created
      @workout = current_user.workouts.find(params[:id])
      @workout.destroy

      redirect_to(workouts_url)
    rescue
      flash[:notice] = 'Cannot destroy workout, it does not exist or you did not create it.'
      redirect_to :back
    end
  end
end
