class User < ActiveRecord::Base
  
  has_many :authorities
  has_many :watched_problems, :through => :authorities, :class_name => 'Problem'
  
  attr_accessible :email, :password, :password_confirmation, :remember_me
  
  #                    ACL
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def is_admin?
    role == 'admin'
  end
end
