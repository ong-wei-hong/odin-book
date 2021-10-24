class LikesController < ApplicationController
	def create
		if Post.find(create_params).likes.pluck(:user_id).include?(current_user.id)
			flash.alert = 'Post already liked'
			return
		end


		like = current_user.likes.build(post_id: create_params)
		unless like.save
			flash.alert = 'Like not saved. Please try again'
		end
	end

	private

	def create_params
		params.require(:post_id)
	end
end
