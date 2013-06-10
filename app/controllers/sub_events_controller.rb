class SubEventsController < ApplicationController
  # GET /sub_events
  # GET /sub_events.json
  before_filter :authenticate_user!
  def index
    

    if user_signed_in?
      @user = current_user
      @sub_events = @user.sub_events
      @sub_events = @sub_events.after(params['start']) if (params['start'])
      @sub_events = @sub_events.before(params['end']) if (params['end'])
    else
      @sub_events = SubEvent.scoped
      @sub_events = @sub_events.after(params['start']) if (params['start'])
      @sub_events = @sub_events.before(params['end']) if (params['end'])
    end


    respond_to do |format|
      format.html # index.html.erb
      format.js  { render :json => @sub_events }
      format.json { render json: @sub_events.as_json }
    end
  end

  # GET /sub_events/1
  # GET /sub_events/1.json
  def show
    @sub_event = SubEvent.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @sub_event }
    end
  end

  # GET /sub_events/new
  # GET /sub_events/new.json
  def new
    @sub_event = SubEvent.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @sub_event }
    end
  end

  # GET /sub_events/1/edit
  def edit
    @sub_event = SubEvent.find(params[:id])
  end

  # POST /sub_events
  # POST /sub_events.json
  def create
    @sub_event = SubEvent.new(params[:sub_event])
    @sub_event.user = current_user
    respond_to do |format|
      if @sub_event.save
        format.html { redirect_to @sub_event, notice: 'Sub event was successfully created.' }
        format.json { render json: @sub_event, status: :created, location: @sub_event }
      else
        format.html { render action: "new" }
        format.json { render json: @sub_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /sub_events/1
  # PUT /sub_events/1.json
  def update
    @sub_event = SubEvent.find(params[:id])

    respond_to do |format|
      if @sub_event.update_attributes(params[:sub_event])
        format.html { redirect_to @sub_event, notice: 'Sub event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @sub_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sub_events/1
  # DELETE /sub_events/1.json
  def destroy
    @sub_event = SubEvent.find(params[:id])
    @sub_event.destroy

    respond_to do |format|
      format.html { redirect_to sub_events_url }
      format.json { head :no_content }
    end
  end
end
