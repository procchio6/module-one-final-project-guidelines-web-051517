require 'pry'

def invalid_input
  puts "Sorry, invalid input, please try again"
end

def greet
  a = Artii::Base.new :font => 'slant'
  puts a.asciify('FareTrakr').colorize(:yellow)

  puts 'Please press:
  1 if you are a returning user,
  2 to create a new account,
  3 to exit'
  gets.chomp
end

def verify_user
  # while true
    puts 'Please enter username:'
    username = gets.chomp
    puts 'Please enter password:'
    password = gets.chomp
    current_user = User.correct_password?(username, password)
    if current_user == false
      puts "Sorry #{username}, but that is not the correct password"
      verify_user
    elsif current_user.nil?
      puts "Sorry, but #{username} is not a current user"
      run
    elsif current_user != false && !current_user.nil?
      a = Artii::Base.new
      puts a.asciify("Welcome #{current_user.username.capitalize}").green
      return current_user
    end
  # end
end

def create_user
  puts 'Please enter username:'
  username = gets.chomp
  if User.find_by(username:username) != nil
    puts 'Sorry, that username was taken!'
    create_user
  else
    puts 'Please enter password:'
    password = gets.chomp
    current_user = User.new_user(username, password)
    current_user
  end
end

def log_in
  case greet
  when '1'
    current_user = verify_user
  when '2'
    current_user = create_user
  when '3'
    puts 'Goodbye!'
    exit
  else
    invalid_input
    log_in
  end
  return current_user
end

def new_ride(current_user)
  puts "What was your driver's number?"
  taxi = gets.chomp
  if Driver.find_by(medallion:taxi) == nil
    puts 'Sorry, that taxi was not found!'
    user_actions(current_user)
  end
  puts 'What was your fare?'
  fare = gets.chomp
  current_user.take_ride(taxi, fare)
end

def view_num_rides(current_user)
  puts 'How many rides would you like to view?'
  numberviewed = gets.chomp.to_i
  ride_iterator(current_user.last_rides(numberviewed))
end

def ride_iterator(lastrides)
  puts "You have no rides!" if lastrides.empty?
  lastrides.each do |ride|
    date = "#{ride.created_at.strftime("%B")} #{ride.created_at.strftime("%d")}"
    puts "On #{date}, you rode in taxi number #{ride.driver.medallion} being driven by #{ride.driver.name}. It cost $#{sprintf("%.2f",ride.fare)}"
  end
end

def cost_over_time(current_user)
  puts 'Please press:
  1 for today
  2 for this week
  3 for the past 30 days
  4 for all of time'
  input = gets.chomp
  case input
  when '1'
    puts "$#{sprintf("%.2f", current_user.cost_of_rides_over_time(0))}"
  when '2'
    puts "$#{sprintf("%.2f", current_user.cost_of_rides_over_time(7))}"
  when '3'
    puts "$#{sprintf("%.2f", current_user.cost_of_rides_over_time(30))}"
  when '4'
    puts "$#{sprintf("%.2f", current_user.cost_of_rides_over_time(10000000))}"
  else
    invalid_input
  end
end

def rides_over_time(current_user)
  puts 'Please press:
  1 for today
  2 for this week
  3 for the past 30 days
  4 for all of time'
  input = gets.chomp
  case input
  when '1'
    rides_list = current_user.list_rides_over_time(0)
    ride_iterator(rides_list)
  when '2'
    rides_list = current_user.list_rides_over_time(7)
    ride_iterator(rides_list)
  when '3'
    rides_list = current_user.list_rides_over_time(30)
    ride_iterator(rides_list)
  when '4'
    rides_list = current_user.list_rides_over_time(10000000)
    ride_iterator(rides_list)
  else
    invalid_input
  end
end

def delete_last_ride(current_user)
  puts "Are you sure?
  #{"THIS WILL BE PERMANENT!".red}
  Press:
    #{"1 for yes".red}
    #{"2 for no".green}"
  choice = gets.chomp
  case choice
  when '1'
    current_user.rides.last.destroy
    puts "The last ride has been deleted!".red
  else
    puts "Nothing has been deleted."
  end
end

def user_actions(current_user)
  while true
    puts "Please press:
  #{"1 to take a ride".green}
  #{"2 to log out".red}
  3 to view recent rides
  4 to delete last ride
  5 to view rides over time
  6 to view graph of rides over time
  7 to view total taxi costs over time"
    case gets.chomp
    when '1'
      new_ride(current_user)
    when '2'
      break
    when '3'
      view_num_rides(current_user)
    when '4'
      delete_last_ride(current_user)
    when '5'
      rides_over_time(current_user)
    when '6'
      current_user.rides_last_30days_count
    when '7'
      cost_over_time(current_user)
    else
      invalid_input
    end
  end
  run
end
