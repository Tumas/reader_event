class AddEventIdtoEventRecord < ActiveRecord::Migration
  def change
    add_column :event_records, :event_id, :integer
  end
end
