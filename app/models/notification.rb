class Notification < ActiveRecord::Base
  attr_accessible :message, :msg_class, :backtrace
  
  belongs_to :client
  
  after_create :mail
  
  has_ancestry
  
  def toggle!
    update_attribute(:solved, self.solved? ? false : true)
  end
  
  def mail
    if self.ancestry.nil?
      ErrorMailer.error(self.id).deliver
    end
  end
  
  def self.root
    where(:ancestry => nil)
  end
  
end
