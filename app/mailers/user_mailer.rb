class UserMailer < ApplicationMailer
	default from: ENV['EMAIL']

	def welcome_email
		@user = params[:user]
		@url = 'https://odin-book-2.herokuapp.com/'
		mail(to: @user.email, subject: 'Welcome to OdinBook')
	end
end
