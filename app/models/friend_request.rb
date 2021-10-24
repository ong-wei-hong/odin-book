class FriendRequest < ApplicationRecord
	belongs_to :from, class_name: :User
  belongs_to :to, class_name: :User

	validates :to_id, presence: true
	validates :from_id, presence: true
end
