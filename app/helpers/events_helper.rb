module EventsHelper
  def repeatEvent
    
  end
  
  def find_events_in_next_hour
    start_time = Time.now
    end_time = Time.now + 1.hour
    list_events = Array.new
    puts 'test'
    @events = Event.all
    @events.each do |event|
      puts event.title
    end
    
    
  end
end
