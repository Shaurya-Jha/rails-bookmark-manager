class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # include Response
  # include ExceptionHandler
  rescue_from ActiveRecord::RecordNotDestroyed, with: :not_destroyed

  # method to use on controllers on endpoints we wish to protect
  def authenticate_request!
    return invalid_authentication if !payload || !AuthenticationTokenService.valid_payload(payload.first)
    current_user!
    invalid_authentication unless @current_user
  end

  def current_user!
    @current_user = User.find_by(id: payload[0]["user_id"])
  end

  private

  # method to extract token for each request headers and verify it with the logged in user
  def payload
    auth_header = request.headers["Authorization"]
    token = auth_header.split(" ").last
    AuthenticationTokenService.decode(token)
  rescue StandardError
    nil
  end

  # helper method that will render invalid authentication messages for invalid login requests
  def invalid_authentication
    render json: { error: "You will need to login first." }, status: :unauthorized
  end
end
