class Contact < ActiveRecord::Base
  attr_accessible :email, :event_id
  belongs_to :event
  validates :email, :presence => true
end
