class Event < ActiveRecord::Base
  has_many :feed_entries
  belongs_to :feed

  def event_occurred? entry
    false
  end

  def create_event_record feed_entry
    false
  end

  def register entry
    feed_entry = add_entry entry
    create_event_record feed_entry
  end

  def add_entry entry
    if feed_entry = feed_entries.where(guid: entry.id).first
      feed_entry
    else
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
