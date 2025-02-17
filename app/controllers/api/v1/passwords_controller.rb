module Api
    module V1
      class PasswordsController < ApplicationController
        before_action :find_user_by_token, only: [:reset_password]
  
        # Step 1: Send Reset Password Email
        def forgot_password
          user = ClaUser.find_by(email: params[:email])
          if user
            user.generate_reset_password_token
            PasswordMailer.with(user: user).forgot_password.deliver_now
            render json: { message: "Reset password instructions sent to #{user.email}" }, status: :ok
          else
            render json: { error: "Email not found" }, status: :not_found
          end
        end
  
        # Step 2: Reset Password
        def reset_password
          if @user.password_reset_token_valid?
            if params[:password].present?
              @user.reset_password!(params[:password])
              render json: { message: "Password successfully reset" }, status: :ok
            else
              render json: { error: "Password cannot be empty" }, status: :unprocessable_entity
            end
          else
            render json: { error: "Reset password token expired. Please request a new one." }, status: :unprocessable_entity
          end
        end
  
        private
  
        def find_user_by_token
          @user = ClaUser.find_by(reset_password_token: params[:token])
          render json: { error: "Invalid or expired token" }, status: :not_found unless @user
        end
      end
    end
  end
