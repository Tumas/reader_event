class FeedEntry < ActiveRecord::Base
  belongs_to :feed
  belongs_to :event
end
