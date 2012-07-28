class Event < ActiveRecord::Base
  belongs_to :feed
  has_many :feed_entries#, :as => :feedable

  # entry here is not feed_entry - it's a rss entry from feedzirra that could be 
  # converted to feed entry if event occurred 
  
  def event_occurred?(entry)
    false
  end

  def add_entry(entry)
    unless feed_entries.exists? guid: entry.id
      self.feed_entries.create!(
        feed_id: self.feed.id,
        title: entry.title,
        url:  entry.url,
        guid: entry.id,
        summary: entry.summary,
        published_at: entry.published
      )
    end
  end
end
