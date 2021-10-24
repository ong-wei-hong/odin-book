class Friend < ApplicationRecord
	belongs_to :friend_a, class_name: :User
  belongs_to :friend_b, class_name: :User

  validates :friend_a, presence: true
  validates :friend_b, presence: true
end
