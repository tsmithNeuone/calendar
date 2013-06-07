class Event < ActiveRecord::Base
  
  attr_accessible :title, :starts_at, :ends_at, :all_day, :description, :contacts_attributes, :sub_events_attributes, :ignore_holidays, :recurring, :recurring_ends_at, :notify_contacts
  belongs_to :user
  has_many :contacts, :dependent => :destroy
  has_many :sub_events, :dependent => :destroy
  accepts_nested_attributes_for :contacts, allow_destroy: true, :reject_if => proc { |attributes| attributes['email'].blank? }
  accepts_nested_attributes_for :sub_events
  validates_associated :contacts
  



  before_save do
    
     
    if self.recurring == 'Daily'
      day = self.starts_at + 1.day
      end_date = self.recurring_ends_at
      while day < end_date
        se = self.sub_events.build
        se.title = self.title
        se.all_day = self.all_day
        se.starts_at = day
        se.ends_at = day
        se.notify_contacts = self.notify_contacts
        se.description = self.description
        se.event_id = self.id
        se.save
        day = day + 1.day
      end
    end
    case 'ets'
    when 'Daily - Weekdays only'
      day = self.starts_at + 1.day
      end_date = self.recurring_ends_at
      while day < end_date
        if not day.saturday? and not day.sunday?
          se = self.sub_events.build
          se.title = self.title
          se.all_day = self.all_day
          se.starts_at = day
          se.ends_at = day
          se.notify_contacts = self.notify_contacts
          se.description = self.description
          se.event_id = self.id
          se.save
          day = day + 1.day
        end
      end
      
    when 'Weekly'
      
    when 'Bi-weekly'
      
    when 'Monthly'
      
    when 'Quarterly'
      
    when 'Semi-Anually'
      
    when 'Annually'
      
    else
      #don't recur anything
    end
    se1 = self.sub_events.build
    se1.title = self.title
    se1.all_day = self.all_day
    se1.starts_at = self.starts_at + 1.day
    se1.ends_at = self.starts_at + 1.day
    se1.notify_contacts = self.notify_contacts
    se1.description = self.description
    se1.event_id = self.id
    se1.save
  end
  
  scope :before, lambda {|end_time| {:conditions => ["ends_at < ?", Event.format_date(end_time)] }}
  scope :after, lambda {|start_time| {:conditions => ["starts_at > ?", Event.format_date(start_time)] }}
  
  # need to override the json view to return what full_calendar is expecting.
  # http://arshaw.com/fullcalendar/docs/event_data/Event_Object/
  def as_json(options = {})
    {
      :id => self.id,
      :title => self.title,
      :description => self.description || "",
      :start => starts_at.rfc822,
      :end => ends_at.rfc822,
      :allDay => self.all_day,
      :recurring => false,
      :url => Rails.application.routes.url_helpers.event_path(id)
    }
    
  end
  
  def self.format_date(date_time)
    Time.at(date_time.to_i).to_formatted_s(:db)
  end
  
 
end