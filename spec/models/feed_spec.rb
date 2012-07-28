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
      UserUploadEvent.any_instance.expects(:event_occurred?).once.returns(:false)

      @feed.check_events([@rss_entry])
    end
  end
end
