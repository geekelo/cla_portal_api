module Api
  module V1
    class RegistrationController < ApplicationController
      before_action :set_user, only: [:update]

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

      def update
        if update_params[:email].present? && ClaUser.where.not(id: @user.user_id).exists?(email: update_params[:email])
          render json: { error: 'Email already taken' }, status: :conflict
          return
        end

        if @user.update(update_params)
          render json: { message: 'User updated successfully' }, status: :ok
        else
          render json: { error: 'Something went wrong updating CLA user' }, status: :unprocessable_entity
        end
      end

      private

      def set_user
        @user = ClaUser.find_by(user_id: params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'User not found' }, status: :not_found
      end

      def sign_up_params
        params.require(:user).permit(:email, :password, :password_confirmation, :name, :cla_role_id, :cla_cohort_id,
                                     :phone_number, :birthday)
      end

      def update_params
        params.require(:user).permit(:email, :name, :cla_role_id, :cla_cohort_id, :phone_number, :birthday)
      end

      def email_exists(email)
        ClaUser.exists?(email:)
      end
    end
  end
end
