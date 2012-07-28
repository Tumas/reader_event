require 'spec_helper'

describe Feed do
  context "no feed exists" do
    describe "create from url" do
      before do
        mock = mock()
        mock.expects(:title).returns('foo')
        mock.expects(:description).returns('bar')
        mock.expects(:feed_url).returns('www.test.com')
        Feed.expects(:fetch_feed).returns(mock)
      end

      it "should create feed object" do
        expect {
          Feed.create_from_url 'http://localhost:3000/feed.xml'
        }.to change { Feed.all.size }.to 1 
      end

      it "should fill relevand fede info" do
        Feed.create_from_url 'http://localhost:3000/feed.xml'
        feed = Feed.first
        feed.url.should == 'www.test.com'
        feed.title.should == 'foo'
        feed.description.should == 'bar'
      end
    end
  end

  context "with existing feeds" do
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
end
