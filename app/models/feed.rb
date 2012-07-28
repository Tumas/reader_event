class Feed < ActiveRecord::Base
  has_many :feed_entries
  has_many :events

  validates_presence_of :url

  def update
    check_events Feed.fetch_feed(self.url).entries
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

  def self.create_from_url url
    if feed = self.fetch_feed(url)
      Feed.create!(
        title: feed.title,
        description: feed.description,
        url: feed.feed_url
      )
    end
  end

  private 

  def self.fetch_feed url
    Feedzirra::Feed.fetch_and_parse url
  end
end
