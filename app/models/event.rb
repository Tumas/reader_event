class Event < ActiveRecord::Base
  has_many :feed_entries
  has_many :event_records
  belongs_to :feed

  def event_occurred? entry
    false
  end

  def event_options feed_entry
    {}
  end

  def create_event_record feed_entry
    unless event_records.where(:feed_entry_id => feed_entry.id).any?
      options = event_options feed_entry
      options[:feed_entry_id] = feed_entry.id
      event_records.create options
    end
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
