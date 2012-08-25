require 'factory_girl'

FactoryGirl.define do
  factory :feed_entry do
    feed
    event

    sequence(:title) { |n| "Feed entry title - #{n}" }
    sequence(:summary) { |n| "Feed entry summary - #{n}" }
    sequence(:published_at) { |n| n.days.ago } 
    sequence(:guid) { |n| n.to_s }
  end

  factory :event do
    feed

    factory :user_upload_event, class: UserUploadEvent do
    end
  end

  factory :followed_user do
  end

  factory :rss_entry, class: Feedzirra::Parser::RSSEntry do
    title "RSS Feed entry title"
    summary "RSS Feed entry summary"
    published 1.day.ago.to_s
    url "http://www.test.com"
  end

  factory :feed do
    url 'www.test.com/rss.xml'
    description 'dummy rss feed description'
    title 'dummy rss feed title'

    factory :feed_with_entries do
      ignore do
        feed_count 3
      end

      after(:create) do |feed, eval|
        FactoryGirl.create_list(:feed_entry, eval.feed_count, feed: feed)
      end
    end
  end
end
