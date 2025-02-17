module Api
  module V1
    class AuthenticationController < ApplicationController
      def create
        user = ClaUser.find_by(email: sign_in_params[:email])
        if user&.authenticate(sign_in_params[:password])
          render json: {
            message: 'User signed in successfully',
            user: ClaUserSerializer.new(user),
            token: JsonWebToken.encode(user_id: user.id)
          }, status: :ok
        else
          render json: { error: 'Invalid email or password' }, status: :unauthorized
        end
      end

      private

      def sign_in_params
        params.require(:user).permit(:email, :password)
      end
    end
  end
end
