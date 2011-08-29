class WorkoutsController < ApplicationController
  # TODO: Disabled for testing... not sure how to create a "verified" account using Factory
  #before_filter :authenticate_user!

  # GET /workouts
  # GET /workouts.xml
  def index
    # Get workouts ranging from 3 days ago to 10 days in advance => 2 week window.
    # TODO: User should be select calendar mode - fixed 2 weeks, month, week etc.
    # TODO: User should be able to navigate forwards and backwards weeks
    first = 3.day.ago(Time.now.beginning_of_day).to_date
    last = 10.day.from_now(Time.now.end_of_day).to_date
    @workouts = Workout.find_by_range(first, last)

    # Add class to each: past, today, future
    @workouts.each do |hash|
      if hash[:date].today?
        hash[:class] = "today"
      elsif hash[:date].past?
        hash[:class] = "past"
      else
        hash[:class] = "future"
      end
    end

    days = %w(Sunday Monday Tuesday Wednesday Thursday Friday Saturday)
    # Get the list of days of the week, only need the first 7
    @days_of_week = (first..last).collect {|x| days[x.wday]}.uniq

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @workouts }
    end
  end

  # GET /workouts/1
  # GET /workouts/1.xml
  def show
    @workout = Workout.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @workout }
    end
  end

  # GET /workouts/new
  # GET /workouts/new.xml
  def new
    @workout = Workout.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @workout }
    end
  end

  # GET /workouts/1/edit
  def edit
    @workout = Workout.find(params[:id])
  end

  # POST /workouts
  # POST /workouts.xml
  def create
    @workout = Workout.new(params[:workout])

    respond_to do |format|
      if @workout.save
        format.html { redirect_to(@workout, :notice => 'Workout was successfully created.') }
        format.xml  { render :xml => @workout, :status => :created, :location => @workout }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @workout.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /workouts/1
  # PUT /workouts/1.xml
  def update
    @workout = Workout.find(params[:id])

    respond_to do |format|
      if @workout.update_attributes(params[:workout])
        format.html { redirect_to(@workout, :notice => 'Workout was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @workout.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /workouts/1
  # DELETE /workouts/1.xml
  def destroy
    @workout = Workout.find(params[:id])
    @workout.destroy

    respond_to do |format|
      format.html { redirect_to(workouts_url) }
      format.xml  { head :ok }
    end
  end
end
