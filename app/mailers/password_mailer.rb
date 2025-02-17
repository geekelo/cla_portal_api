class PasswordMailer < ApplicationMailer
    default from: 'no-reply@cla.jjrsf.org'
  
    def forgot_password
      @user = params[:user]
      @reset_link = "#{Rails.application.credentials.frontend_url}/reset-password?token=#{@user.reset_password_token}"
      mail(to: @user.email, subject: "Reset Your Password")
    end
  end