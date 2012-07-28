class CreateFeedEntries < ActiveRecord::Migration
  def change
    create_table :feed_entries do |t|
      t.integer :feed_id
      t.integer :event_id

      t.string :title
      t.string :url
      t.string :guid

      t.text :summary
      t.datetime :published_at

      t.timestamps
    end
  end
end
