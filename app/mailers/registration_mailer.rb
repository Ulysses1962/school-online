class RegistrationMailer < ApplicationMailer
  def welcome(user)
    @user = user
    mail(to: @user.email, subject: 'Your password on SchoolONLINE')
  end
end
