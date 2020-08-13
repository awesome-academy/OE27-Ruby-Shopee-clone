class ApplicationMailer < ActionMailer::Base
  default from: current_user.name
  layout "mailer"
end
