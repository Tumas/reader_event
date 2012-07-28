require 'spec_helper'

describe UserUploadEvent do
  before do
    @event = FactoryGirl.create :user_upload_event
    @entry = FactoryGirl.build :rss_entry
  end

  describe "create_event_record" do
    before do
      @event.expects(:fetch_users).returns(%w{ Harold })
      @feed_entry = FactoryGirl.create :feed_entry 
      @event.event_occurred? @entry
    end

    it "should create an event record" do
      @event.create_event_record @feed_entry
      @feed_entry.event_records.first.should_not be_nil
    end

    it "should create event record with correct headline" do
      @event.create_event_record @feed_entry
      @feed_entry.event_records.first.headline.should == "Message: User activity detected for: Harold"
    end
  end

  describe "event_occurred?" do
    context "login is required" do
      before do
          FakeWeb.register_uri(:get, "http://www.test.com", :body => File.read('spec/fixtures/user_upload_event_login.html'), :content_type => "text/html")
          FakeWeb.register_uri(:post, "http://www.test.com/takelogin.php", :body => File.read('spec/fixtures/user_upload_event_feed.html'), :content_type => "text/html")
      end

      context "event occurred" do
        it "should be true" do
          @event.stubs(:tracked_users).returns(%w{ Harold })
          @event.event_occurred?(@entry).should be_true
        end
      end

      context "event did not occur" do
        it "should be false" do
          @event.stubs(:tracked_users).returns(%w{ Joe })
          @event.event_occurred?(@entry).should be_false
        end
      end
    end

    context "login is not required" do
      before do
          FakeWeb.register_uri(:get, "http://www.test.com", :body => File.read('spec/fixtures/user_upload_event_feed.html'), :content_type => "text/html")
      end

      context "event occurred" do
        it "should be true" do
          @event.stubs(:tracked_users).returns(%w{ Harold })
          @event.event_occurred?(@entry).should be_true
        end
      end

      context "event did not occur" do
        it "should be false" do
          @event.stubs(:tracked_users).returns(%w{ Joe })
          @event.event_occurred?(@entry).should be_false
        end
      end
    end
  end
end
