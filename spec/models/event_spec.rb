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

    it "should not add multiple entries" do
      expect { 
        2.times { @event.add_entry(@entry) }
      }.to change { @event.feed_entries.size }.to 1
    end

    it "should add transformed entry" do
      feed_entry = @event.add_entry(@entry)
      feed_entry.title.should == "RSS Feed entry title - 1" 
      feed_entry.summary.should == "RSS Feed entry summary - 1" 
    end
  end
end
