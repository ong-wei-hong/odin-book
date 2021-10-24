class CreateFriends < ActiveRecord::Migration[6.1]
  def change
    create_table :friends do |t|
			t.belongs_to :friend_a, foreign_key: { to_table: :users }
			t.belongs_to :friend_b, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
