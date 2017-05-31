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
    if driver
      Ride.create!({user: self, driver: driver, fare: fare})
    end
  end

  def last_rides(number_of_rides = 5)
    self.rides.order("rides.created_at DESC").limit(number_of_rides)
  end

  def cost_of_last_rides(number_of_rides = 5)
    self.rides.order("rides.created_at DESC").limit(number_of_rides).collect(&:fare).sum
  end

  def cost_of_rides_over_time(days)
    date_after = Date.today - days
    self.rides.where("rides.created_at > ?", date_after).collect(&:fare).sum
  end

  def list_rides_over_time(days)
    date_after = Date.today - days
    self.rides.where("rides.created_at > ?", date_after)
  end
end
