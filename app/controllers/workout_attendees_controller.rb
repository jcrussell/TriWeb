class WorkoutAttendeesController < ApplicationController
  # GET /workout_attendees
  # GET /workout_attendees.xml
  def index
    @workout_attendees = WorkoutAttendee.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @workout_attendees }
    end
  end

  # GET /workout_attendees/1
  # GET /workout_attendees/1.xml
  def show
    @workout_attendee = WorkoutAttendee.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @workout_attendee }
    end
  end

  # GET /workout_attendees/new
  # GET /workout_attendees/new.xml
  def new
    @workout_attendee = WorkoutAttendee.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @workout_attendee }
    end
  end

  # GET /workout_attendees/1/edit
  def edit
    @workout_attendee = WorkoutAttendee.find(params[:id])
  end

  # POST /workout_attendees
  # POST /workout_attendees.xml
  def create
    @workout_attendee = WorkoutAttendee.new(params[:workout_attendee])

    respond_to do |format|
      if @workout_attendee.save
        format.html { redirect_to(@workout_attendee, :notice => 'Workout attendee was successfully created.') }
        format.xml  { render :xml => @workout_attendee, :status => :created, :location => @workout_attendee }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @workout_attendee.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /workout_attendees/1
  # PUT /workout_attendees/1.xml
  def update
    @workout_attendee = WorkoutAttendee.find(params[:id])

    respond_to do |format|
      if @workout_attendee.update_attributes(params[:workout_attendee])
        format.html { redirect_to(@workout_attendee, :notice => 'Workout attendee was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @workout_attendee.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /workout_attendees/1
  # DELETE /workout_attendees/1.xml
  def destroy
    @workout_attendee = WorkoutAttendee.find(params[:id])
    @workout_attendee.destroy

    respond_to do |format|
      format.html { redirect_to(workout_attendees_url) }
      format.xml  { head :ok }
    end
  end
end
