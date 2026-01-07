require "jwt"
require "json"
require "bcrypt"

class AuthenticationController < ApplicationController
  protect_from_forgery with: :null_session

  # register new user
  def register
    user = User.new(user_params)

    # encrypt the password with bcrypt
    hashed_password = BCrypt::Password.create(params[:password_digest])
    # cannot update the columns as the column is not saved so haw can we update the column
    # user.update_column(:password_digest, hashed_password)
    user.password_digest = hashed_password

    if user.save
      render json: { message: "User created successfully." }
    else
      render json: { message: user.errors.full_message }
    end
  end

  # login user
  def login
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      # token = generate_token(user.id)
      render json: { user_id: user.id, token: AuthenticationTokenService.call(user.id) }, status: :ok
    else
      render json: { error: "Invalid credentials" }, status: :unauthorized
    end
  end

  private
  # accept user params and parse them in new user creation
  def user_params
    params.require(:authentication).permit(:name, :username, :email, :password_digest)
  end

  # generate jwt token for auth credentials
  def generate_token(user_id)
    JWT.encode({ user_id: user_id }, Rails.application.credentials.secret_key_base)
  end

end