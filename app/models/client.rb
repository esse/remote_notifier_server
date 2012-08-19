class Client < ActiveRecord::Base
  attr_accessible :secret, :token
  
  belongs_to :user
end
