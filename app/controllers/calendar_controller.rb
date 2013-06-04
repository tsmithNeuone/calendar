# calendars are not (yet) a resource in the rails sense of thw word - we
# simply have a url like calendar/index to get the one and only calendar
# this demo serves up.
class CalendarController < ApplicationController
  def index
      if user_signed_in?
        @event = Event.new
      @user = current_user
      @events = @user.events
      @events = @events.after(params['start']) if (params['start'])
      @events = @events.before(params['end']) if (params['end'])
    else
      @events = Event.scoped
      @events = @events.after(params['start']) if (params['start'])
      @events = @events.before(params['end']) if (params['end'])
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @events }
    end
  end
  def new
    @event = Event.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @event }
    end
  end

end 