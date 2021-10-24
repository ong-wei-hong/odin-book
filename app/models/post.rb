class Post < ApplicationRecord
	belongs_to :user

  has_many :likes
  has_many :comments

  belongs_to :content, polymorphic: true

	validates :user_id, presence: true
	validates :title, presence: true
	validates :content, presence: true

	def self.get_likes_string(post_id)
		user_names = nil

		Post.find(post_id).likes.find_each do |like|
			if user_names
				user_names += ", #{like.user.name}"
			else
				user_names = like.user.name
			end
		end

		user_names + ' liked this post'
	end
end
