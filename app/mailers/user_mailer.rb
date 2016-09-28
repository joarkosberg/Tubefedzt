class UserMailer < ApplicationMailer

  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to Tubefedzt')
  end

  def mail_all(user, subject, message)
    @message = message
    mail(to: user.email, subject: subject)
  end
end
