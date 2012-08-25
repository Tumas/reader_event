require 'spec_helper'

describe Event do
  before do
    @event = FactoryGirl.create :event
    @entry = FactoryGirl.build :rss_entry
  end

  describe "event_occurred?" do
    it "should not occur for the abstract class" do
      @event.event_occurred?(@entry).should be_false
    end
  end

  describe "add_entry" do
    it "should add entry" do
      expect { 
        @event.add_entry(@entry)
      }.to change { @event.feed_entries.size }.to 1
    end

    it "should specify event relationship" do
      er = @event.add_entry(@entry)
      er.event.should == @event
    end

    it "should return feed_entry" do
      @event.add_entry(@entry).should be_instance_of(FeedEntry)
    end

    it "should find if not create feed_entry" do
      @event.add_entry(@entry)
      @event.add_entry(@entry).should be_instance_of(FeedEntry)
    end

    it "should not add multiple entries" do
      expect { 
        2.times { @event.add_entry(@entry) }
      }.to change { @event.feed_entries.size }.to 1
    end


    it "should add transformed entry" do
      feed_entry = @event.add_entry(@entry)
      feed_entry.title.should == "RSS Feed entry title" 
      feed_entry.summary.should == "RSS Feed entry summary" 
    end
  end

  describe "register" do
    it "should not create multiple event records" do
      expect { 
        2.times { @event.register(@entry) }
      }.to change { EventRecord.all.size }.to(1)
    end
  end
end
