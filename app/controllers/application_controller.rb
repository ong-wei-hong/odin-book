class ApplicationController < ActionController::Base
	def back_with_link_in_params(anchor='')
		redirect_to request.referrer.split(/\?/).first + "?link=post_#{anchor}"
	end

	def back_without_params
		redirect_to request.referrer.split(/\?/).first
	end
end
