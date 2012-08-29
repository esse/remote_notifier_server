class Client < ActiveRecord::Base
  attr_accessible :name, :token, :secret
  
  has_many :notifications
  
  belongs_to :user
  
  has_many :accessed_user, :through => :user_client_accesses, :source => :user
  
  has_many :user_client_accesses
end
