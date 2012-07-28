class Feed < ActiveRecord::Base
  has_many :feed_entries
  has_many :events

  validates_presence_of :url

  def update
    feed = Feedzirra::Feed.fetch_and_parse(self.url)
    check_events feed.entries
  end

  def check_events entries
    self.events.each do |event|
      entries.each do |entry|
        if event.event_occurred? entry
          event.register entry
        end
      end
    end
  end
end
