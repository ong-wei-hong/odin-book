class CommentsController < ApplicationController
	def create
		if create_params[:text].length > 0
			comment = current_user.comments.build(create_params)
			if comment.save
				flash.notice = 'Comment saved'
			else
				flash.alert = 'Comment not saved. Please try again'
			end
		else
			flash.alert = 'Comment text missing'
		end

		back_with_link_in_params(create_params[:post_id])
	end

	private

	def create_params
		params.require(:comments).permit(:post_id, :text)
	end
end
