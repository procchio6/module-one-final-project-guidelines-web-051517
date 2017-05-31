class User < ActiveRecord::Base
  attr_accessor :username, :password

  has_many :rides
  has_many :drivers, through: :rides

  validates :username, :password, presence: true
  validates :username, uniqueness: true

end
