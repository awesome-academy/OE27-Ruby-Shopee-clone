class ApplicationMailer < ActionMailer::Base
  default from: ENV["host_user_name"]
  layout :mailer
end
