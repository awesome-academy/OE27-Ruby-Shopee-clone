class UserMailer < ApplicationMailer
  def welcome_email user
    mail(to: user.email, subject: t "order.thankyou")
  end
end
