class PostsController < ApplicationController
	before_action :authenticate_user!
	def index
		current_user_id = current_user.id
		@posts = Post.where(user_id: User.friends_ids(current_user_id) << current_user_id)

		@link = params[:link]
	end

	def create
		if create_params[:title].length > 0
			post = current_user.posts.build(title: create_params[:title])

			if create_params[:is_image]
				image_content = ImageContent.create
				image_content.image.attach(create_params[:image])

				if image_content.image.key
					post.content = image_content

					if post.save
						flash.notice = 'Post saved'
					else
						flash.alert = 'Error please try again'
						redirect_after_create_error(create_params[:is_image])
						return
					end
				else
					flash.alert = 'Image content is empty'
					redirect_after_create_error(create_params[:is_image])
					return
				end

			else
				text_content = TextContent.new(text: create_params[:content])

				if text_content.save
					post.content = text_content

					if post.save
						flash.notice = 'Post saved'
					else
						flash.alert = 'Error please try again'
						redirect_after_create_error(create_params[:is_image])
						return
					end

				else
					flash.alert = 'Text content is empty'
					redirect_after_create_error(create_params[:is_image])
					return
				end
			end

		else
			flash.alert = 'Post title is empty'
			redirect_after_create_error(create_params[:is_image])
			return
		end
		redirect_to root_path
	end

	def new
		unless params[:image]
			render 'text_post_form'
		end
	end

	private

	def create_params
		params.require(:post).permit(:title, :content, :is_image, :image)
	end

	def redirect_after_create_error(is_image)
		if is_image
			redirect_to 'http://localhost:3000/posts/new?image=true'
			return
		end
		back_without_params
	end

end
