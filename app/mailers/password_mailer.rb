class PasswordMailer < ApplicationMailer

    def forgot_password
      @user = params[:user]
      @reset_link = "#{Rails.application.credentials.dig(:frontend_url)}/reset-password?token=#{@user.reset_password_token}"
      mail(to: @user.email, 
      subject: "Reset Your Password")
    end
  end