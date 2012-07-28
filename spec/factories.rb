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
  end

  factory :rss_entry, class: 'Feedzirra::Parser::RSSEntry' do
    sequence(:title) { |n| "RSS Feed entry title - #{n}" }
    sequence(:summary) { |n| "RSS Feed entry summary - #{n}" }
    sequence(:published) { |n| n.days.ago.to_s } 
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
