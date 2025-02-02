class JsonWebToken
  def self.encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, ENV.fetch('JWT_SECRET_KEY', nil), 'HS256')
  end

  def self.decode(token)
    JWT.decode(token, ENV.fetch('JWT_SECRET_KEY', nil), true, algorithm: 'HS256').first
  rescue JWT::ExpiredSignature
    Rails.logger.error('JWT Decode Error: Token has expired')
    nil
  rescue JWT::DecodeError => e
    Rails.logger.error("JWT Decode Error: #{e.message}")
    nil
  end
end
