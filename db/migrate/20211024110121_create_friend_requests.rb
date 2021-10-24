class CreateFriendRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :friend_requests do |t|
			t.belongs_to :from, foreign_key: { to_table: :users }
			t.belongs_to :to, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
