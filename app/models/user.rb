class User < ActiveRecord::Base
  attr_accessor :username, :password

  has_many :rides
  has_many :drivers, through: :rides

end
