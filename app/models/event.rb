class Event < ActiveRecord::Base
  has_many :feed_entries
  belongs_to :feed

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
