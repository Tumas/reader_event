class FeedEntry < ActiveRecord::Base
  belongs_to :feed
  belongs_to :event#, polymorphic: true
end
