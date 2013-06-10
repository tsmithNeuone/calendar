class SubEvent < ActiveRecord::Base
  attr_accessible :all_day, :description, :ends_at, :notify_contacts, :starts_at, :title
  belongs_to :event, :foreign_key => "event_id"
  belongs_to :user, :foreign_key => "user_id"
  
  scope :before, lambda {|end_time| {:conditions => ["ends_at < ?", SubEvent.format_date(end_time)] }}
  scope :after, lambda {|start_time| {:conditions => ["starts_at > ?", SubEvent.format_date(start_time)] }}
  
  # need to override the json view to return what full_calendar is expecting.
  # http://arshaw.com/fullcalendar/docs/event_data/Event_Object/
  def as_json(options = {})
    {
      :id => self.id,
      :title => self.title,
      :description => self.description || "",
      :start => (starts_at + 5.hours),
      :end => (ends_at + 5.hours),
      :allDay => self.all_day,
      :recurring => false,
      :url => Rails.application.routes.url_helpers.sub_event_path(id)
    }
    
  end
  
  def self.format_date(date_time)
    Time.at(date_time.to_i).to_formatted_s(:db)
  end
end
