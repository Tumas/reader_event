class UpdateFeeds
  @queue = :updates

  def self.perform
    Feed.all.map &:update
  end
end
