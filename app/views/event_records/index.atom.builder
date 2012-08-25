atom_feed do |feed|
  feed.title "FeedReader Events"
  feed.updated @event_records.maximum(:created_at)
  
  @event_records.each do |er|
    feed.entry er, published: er.feed_entry.published_at do |entry|
      entry.title er.headline
      entry.content er.feed_entry.url
    end
  end
end
