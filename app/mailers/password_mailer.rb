class PasswordMailer < ApplicationMailer
    # default from: 'no-reply@cla.jjrsf.org'
  
    def forgot_password
      @user = params[:user]
      @reset_link = "#{Rails.application.credentials.dig(:frontend_url)}/reset-password?token=#{@user.reset_password_token}"
      mail(to: @user.email, 
      from: "team@jjrsf.org",
      subject: "Reset Your Password")
    end
  end