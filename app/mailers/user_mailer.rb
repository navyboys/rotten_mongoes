class UserMailer < ApplicationMailer
  def delete_notification_email(user)
    @user = user
    @url  = 'http://example.com/register'
    mail(to: @user.email, subject: 'Your account is deleted')
  end
end
