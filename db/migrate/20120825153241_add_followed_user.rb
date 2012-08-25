class AddFollowedUser < ActiveRecord::Migration
  def change
    create_table :followed_users do |t|
      t.string :name
      t.integer :event_id
      t.timestamps
    end
  end
end
