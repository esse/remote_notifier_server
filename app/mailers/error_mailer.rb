class ErrorMailer < ActionMailer::Base
  default from: "information@remotenotifier.com"
  
  def error(error_id)
    @notification = Notification.find(error_id)
  end
  
end
