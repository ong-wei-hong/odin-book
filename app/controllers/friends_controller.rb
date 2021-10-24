class FriendsController < ApplicationController
	before_action :authenticate_user!
	def create
    friend_request = FriendRequest.find(create_params)

		unless friend_request
			flash.alert = 'Friend request not found'
			return
		end

    friend_a_id = friend_request.to_id
    friend_b_id = friend_request.from_id

    if friend_a_id == current_user.id
      friend = Friend.new(friend_a_id: friend_a_id, friend_b_id: friend_b_id)
      if friend.save
        friend_request.delete
      else
        flash.alert = "Friend request not accepted. Please try again"
      end
    else
      flash.alert = "Error, you are unable to accept friend request"
    end
  end

  private

  def create_params
    params.require(:friend_request_id)
  end
end
