class Notification < ActiveRecord::Base
  attr_accessible :message, :msg_class, :backtrace
  
  belongs_to :client
  
  has_ancestry
  
  def toggle!
    update_attribute(:solved, self.solved? ? false : true)
  end
  
end
