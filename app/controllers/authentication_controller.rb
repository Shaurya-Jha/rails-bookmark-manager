require "jwt"
require "json"
require "bcrypt"

class AuthenticationController < ApplicationController
  protect_from_forgery with: :null_session

  # register new user
  def register
    @user = User.new(user_params)

    if @user.save
      # send welcome email to the user
      UserMailer.with(user: @user).welcome_email.deliver_now
      render json: { message: "User created successfully." }, status: :created
    else
      render json: { message: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # login user
  def login
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      render json: { user_id: user.id, token: AuthenticationTokenService.call(user.id) }, status: :ok
    else
      render json: { error: "Invalid credentials" }, status: :unauthorized
    end
  end

  private
  # accept user params and parse them in new user creation
  def user_params
    params.require(:authentication).permit(:name, :username, :email, :password)
  end
end
