# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  # def twitter
  # end
	skip_before_action :verify_authenticity_token, only: :facebook

  def facebook
    @user, new_user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      UserMailer.with(user: @user).welcome_email.deliver_later if new_user
      sign_in_and_redirect @user
      set_flash_message(:notice, :success, kind: "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"].except(:extra)
			flash.alert = 'Error please register for an account instead'
      redirect_to new_user_registration_url
    end
  end

  # More info at:
  # https://github.com/heartcombo/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  def failure
		flash.alert = 'Error please try again later'
    redirect_to root_path
  end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end

end
