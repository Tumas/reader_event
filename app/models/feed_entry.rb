class FeedEntry < ActiveRecord::Base
  belongs_to :feed
  belongs_to :event

  has_many :event_records
end
