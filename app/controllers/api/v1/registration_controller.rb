module Api
  module V1
    class RegistrationController < ApplicationController
      def create
        if email_exists(sign_up_params[:email])
          render json: { error: 'Email already exists' }, status: :conflict
        else
          user = ClaUser.new(sign_up_params)
          if user.save
            render json: { message: 'User created successfully' }, status: :created
          else
            render json: { error: 'Something went wrong creating CLA user' }, status: :unprocessable_entity
          end
        end
      end

      private

      def sign_up_params
        params.require(:user).permit(:email, :password, :password_confirmation, :name, :cla_role_id, :cla_cohort_id)
      end

      def email_exists(email)
        ClaUser.exists?(email: email)
      end
    end
  end
end
