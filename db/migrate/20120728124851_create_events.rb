class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :feed_id
      t.string :title 
      t.text :description

      t.timestamps
    end
  end
end
