class WelcomeMailer < ActionMailer::Base
  default from: "no-reply@bonsai-list.com"

  def new_account_email(user)
    @user = user
    mail(to: @user.email, subject: "Thanks for signing up! | Bonsai List")
  end
end
