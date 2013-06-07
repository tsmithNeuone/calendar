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
        se.user_id = self.user_id
        se.save
        day = day + 1.day
      end
    elsif self.recurring == 'Daily - Weekdays only'
      day = self.starts_at + 1.day
      end_date = self.recurring_ends_at
      while day < end_date
        if !day.saturday? && !day.sunday?
          se = self.sub_events.build
          se.title = self.title
          se.all_day = self.all_day
          se.starts_at = day
          se.ends_at = day
          se.notify_contacts = self.notify_contacts
          se.description = self.description
          se.event_id = self.id
          se.user_id = self.user_id
          se.save
        end
        day = day + 1.day
      end
    elsif self.recurring == 'Weekly'
      day = self.starts_at + 1.week
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
        se.user_id = self.user_id
        se.save
        day = day + 1.week
      end
    elsif self.recurring == 'Bi-weekly'
      day = self.starts_at + 2.week
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
        se.user_id = self.user_id
        se.save
        day = day + 2.week
      end
    elsif self.recurring == 'Monthly'
      day = self.starts_at + 1.month
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
        se.user_id = self.user_id
        se.save
        day = day + 1.month
      end
    elsif self.recurring == 'Quarterly'
      day = self.starts_at + 3.months
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
        se.user_id = self.user_id
        se.save
        day = day + 3.months
      end
    elsif self.recurring == 'Semi-Anually'
      day = self.starts_at + 6.months
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
        se.user_id = self.user_id
        se.save
        day = day + 6.months
      end
    elsif self.recurring == 'Anually'
      day = self.starts_at + 1.year
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
        se.user_id = self.user_id
        se.save
        day = day + 1.year
      end
    end  
      
      
      
    
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