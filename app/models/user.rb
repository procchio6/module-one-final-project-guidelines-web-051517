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

  def take_ride(taxi, fare)
    driver = Driver.find_by(medallion: taxi)
    Ride.create({user: self, driver: driver, fare: fare})
  end

  def last_rides(number_of_rides = 5)
    self.rides.order("rides.created_at DESC").limit(number_of_rides)
  end
end
