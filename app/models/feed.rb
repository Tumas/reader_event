class Feed < ActiveRecord::Base
  has_many :feed_entries

  #has_many :events
  # subclasses implement check(feed_entry)
  #
  # NO! -> feed_entries are for saved 
  # events.each do |event|
  #   feed_entries.each do |feed|
  #     event.chec fe
  #   end
  # end  
  #
  # def register(fe)
  # end

end
