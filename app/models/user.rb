class User < ActiveRecord::Base
  has_many :rides
  has_many :drivers, through: :rides

  validates :username, :password, presence: true
  validates :username, uniqueness: true

  def self.correct_password?(username, password)
    user = User.find_by ({username:username})
    if user
      user.password == password ? user : false
    end
  end

  def self.new_user(username, password)
    User.create!({username: username, password: password})
  end
end
