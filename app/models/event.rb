class Event < ActiveRecord::Base
  
  attr_accessible :title, :starts_at, :ends_at, :all_day, :description, :contacts_attributes, :schedule, :ignore_holidays, :recurring, :notify_contacts
  belongs_to :user
  has_many :contacts, :dependent => :destroy
  accepts_nested_attributes_for :contacts, allow_destroy: true, :reject_if => proc { |attributes| attributes['email'].blank? }
  validates_associated :contacts
  

  before_save do
    
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