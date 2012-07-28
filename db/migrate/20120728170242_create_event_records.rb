class CreateEventRecords < ActiveRecord::Migration
  def change
    create_table :event_records do |t|
      t.string :headline
      t.integer :feed_entry_id

      t.timestamps
    end
  end
end
