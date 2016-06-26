class UserMailer < ApplicationMailer
  default from: 'fruits@rottenmangoes.com'

  def goodbye_email(user)
    @user = user
    mail(to: @user.email, subject: "Account deleted")
  end

end
