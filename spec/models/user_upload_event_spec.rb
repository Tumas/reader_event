require 'spec_helper'

describe UserUploadEvent do
  before do
    @event = FactoryGirl.create :user_upload_event
  end

  it "should work" do
    @event.feed.should_not be_nil
  end
end
