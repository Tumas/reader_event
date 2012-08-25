class EventRecord < ActiveRecord::Base
  belongs_to :feed_entry
  belongs_to :event
end
