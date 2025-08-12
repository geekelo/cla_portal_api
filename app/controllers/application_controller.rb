class ApplicationController < ActionController::API
  attr_reader :current_user

  private

  def authenticate_user!
    Rails.logger.info "Auth token: #{auth_token}"
    Rails.logger.info "JWT_SECRET_KEY present: #{ENV['JWT_SECRET_KEY'].present?}"
    
    payload = JsonWebToken.decode(auth_token)
    return render json: { error: "Invalid auth token" }, status: :unauthorized unless payload
    
    @current_user = ClaUser.find_by(user_id: payload["user_id"])
  rescue JWT::DecodeError => e
    Rails.logger.error "JWT Decode Error: #{e.message}"
    render json: { error: "Invalid auth token" }, status: :unauthorized
  end

  def auth_token
    @auth_token ||= request.headers["Authorization"].to_s.split.last
  end
end