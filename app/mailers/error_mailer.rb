class ErrorMailer < ActionMailer::Base
  default from: "information@remotenotifier.com"
  
  include Resque::Mailer
  
  def error(error_id)
    @notification = Notification.find(error_id)
    mail(:to => @notification.client.user.email, :subject => "Error in #{@notification.client.name} - #{@notification.msg_class}")
  end
  
end
