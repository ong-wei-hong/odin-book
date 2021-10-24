class FriendRequestsController < ApplicationController
	before_action :authenticate_user!
  def create
		current_user_id = current_user.id

		unless User.relation_between(current_user_id, create_params) === :no_relation
			flash.alert = 'Unable to send friend request as user is a friend or in exisitng friend requests'
			return
		end

		friendRequest = FriendRequest.new(to_id: create_params, from_id: current_user_id)

		unless friendRequest.save
			flash.alert = "Friend request not sent. Please try again"
		end
  end

  private

  def create_params
    params.require(:to_id)
  end
end
