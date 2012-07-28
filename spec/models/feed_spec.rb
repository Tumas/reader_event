require 'spec_helper'

describe Feed do
  before do
    @feed = FactoryGirl.create :feed
    @event = FactoryGirl.create :event, feed: @feed
    @user_event = FactoryGirl.create :user_upload_event, feed: @feed
    @rss_entry = FactoryGirl.build :rss_entry
  end

  describe "check_events" do
    it "should call correct event checker" do
      any_upload_event.expects(:event_occurred?).once.returns(false)
      @feed.check_events([@rss_entry])
    end

    context 'event occurred' do
      it "should register event" do
        any_upload_event.expects(:event_occurred?).once.returns(true)
        any_upload_event.expects(:create_event_record).once
        @feed.check_events([@rss_entry])
      end
    end

    context "event did not occur" do
      it "should not register event" do
        any_upload_event.expects(:event_occurred?).once.returns(false)
        any_upload_event.expects(:create_event_record).never
        @feed.check_events([@rss_entry])
      end
    end
  end
end
