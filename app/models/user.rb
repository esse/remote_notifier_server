class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body
  
  has_many :clients
  
  has_many :accessing_clients, :through => :user_client_accesses, :source => :client
  
  has_many :user_client_accesses
  
  def all_clients
    x = clients || []
    y = accessing_clients || []
    x+y
  end
  
  def find_client(c_id)
    clients.find(c_id) || accessing_clients.find(c_id)
  end
  
end
