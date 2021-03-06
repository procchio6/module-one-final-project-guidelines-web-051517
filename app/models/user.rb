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
    self.rides.where("rides.created_at > ?", date_after).order("rides.created_at DESC")
  end

  def rides_last_30days_count
    date_after = Date.today - 30
    rides_hash = {}
    (date_after..Date.today).each do |date|
      hash_input = self.rides.group("date(created_at)").where("date(created_at) = ?", date).count.values.first
      case hash_input
      when nil
        rides_hash[date.to_s] = 0
      else
        rides_hash[date.to_s] = hash_input
      end
    end
    puts "DAY        RIDES"
    rides_hash.keys.each do |k|
      puts "%10s %3d %s\n" % [k, rides_hash[k], "🚕  ".yellow * rides_hash[k]]
    end
  end

  def rides_last_30days_cost
    date_after = Date.today - 30
    cost_hash = {}
    (date_after..Date.today).each do |date|
      hash_input = self.rides.group("date(created_at)").where("date(created_at) = ?", date).sum("fare").values.first
      case hash_input
      when nil
        cost_hash[date.to_s] = 0
      else
        cost_hash[date.to_s] = hash_input
      end
    end
    puts "    DAY      COST"
    cost_hash.keys.each do |k|
      cost = cost_hash[k] / 3
      if cost > 50
        cost = 50
      end
      puts "%10s %7s %s\n" % [k, sprintf("$%.2f", cost_hash[k]), "💰" * cost]
    end
  end

end
