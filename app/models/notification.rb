class Notification < ActiveRecord::Base
  attr_accessible :message, :msg_class, :backtrace
end
