class Client < ActiveRecord::Base
  attr_accessible :name, :token, :secret
  
  has_many :notifications
  
  belongs_to :user
end
