class UsersController < ApplicationController
	before_action :authenticate_user!

	def search
    @searched_users = User.search(search_params[:name])
    unless search_params.empty?
      @searched = true
      @previous_result = search_params[:name]
    end
  end

	def notification
		@received_friend_requests = current_user.received_friend_requests
	end

	def show
		@user_id = params[:id]
		@user = User.find(params[:id])
		@current_user_id = current_user.id
		@relation_with_current_user = User.relation_between(@current_user_id, @user_id)
		@friends = User.where(id: User.friends_ids(@user_id))
		@user_name = @user.name
		@posts = Post.where(user_id: @user_id)

		@link = params[:link]
	end

	def update
		if current_user.id.to_s == params[:id]
			if update_params[:avatar]
				current_user.update(update_params)
				if current_user.save
					flash.notice = "Profile picture updated"
				else
					flash.alert = "Profile picture not updated. Please try again"
				end
			else
				flash.alert = "Profile picture not attached"
			end
		else
			flash.alert = "Unable to change this user's profile picture"
		end
		back_without_params
	end

	private

	def update_params
		params.require(:user).permit(:avatar)
	end

  def search_params
    params.fetch(:search, {}).permit(:name)
  end
end
