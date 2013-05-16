class UserMailer < ActionMailer::Base
  default from: "customer_service@photoline.com"

  def signup_confirmation(user)
    @user = user

    mail to: user.email, subject: "Welcome to Photoline"
  end
end
