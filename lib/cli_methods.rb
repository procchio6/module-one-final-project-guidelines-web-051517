require 'pry'

def invalid_input
  puts "Sorry, invalid input, please try again"
end

def greet
  puts '
888                   d8b
888                   Y8P
888
888888 8888b. 888  888888
888        88b Y8bd8P 888
888   .d888888  X88K  888
Y88b. 888  888.d8  8b.888
  Y888 Y888888888  888888
  '
  puts 'Welcome to FareTrakr™'
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
      puts "Welcome back #{current_user.username}"
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
  puts 'What was your fare?'
  fare = gets.chomp
  current_user.take_ride(taxi, fare)
end

def view_num_rides(current_user)
  puts 'How many rides would you like to view?'
  numberviewed = gets.chomp.to_i
  lastrides = current_user.last_rides(numberviewed)
  puts "You have no rides!" if lastrides.empty?
  ride_iterator(lastrides)
end

def ride_iterator(lastrides)
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
    puts "$#{current_user.cost_of_rides_over_time(0)}"
  when '2'
    puts "$#{current_user.cost_of_rides_over_time(7)}"
  when '3'
    puts "$#{current_user.cost_of_rides_over_time(30)}"
  when '4'
    puts "$#{current_user.cost_of_rides_over_time(10000000)}"
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

def user_actions(current_user)
  while true
    puts 'Please press:
  1 to take a ride
  2 to log out
  3 to view recent rides
  4 to view rides over time
  5 to view total taxi costs over time'
    case gets.chomp
    when '1'
      new_ride(current_user)
    when '2'
      break
    when '3'
      view_num_rides(current_user)
    when '4'
      rides_over_time(current_user)
    when '5'
      cost_over_time(current_user)
    else
      invalid_input
    end
  end
  run
end
