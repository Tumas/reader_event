class Event < ActiveRecord::Base
  belongs_to :feed
  has_many :feed_entries#, :as => :feedable
end
