class UserMailer < ApplicationMailer
	default from: ENV['EMAIL']

	def welcome_email
		@user = params[:user]
		@url = 'localhost:3000'
		mail(to: @user.email, subject: 'Welcome to OdinBook')
	end
end
