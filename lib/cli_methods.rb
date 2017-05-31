def greet
  puts 'Welcome to FairTrakr'
  puts '
888                   d8b 
888                   Y8P 
888                       
888888 8888b. 888  888888 
888        88b Y8bd8P 888 
888   .d888888  X88K  888 
Y88b. 888  888.d8  8b.888 
  Y888 Y888888888  888888'
                          
  puts 'Press 1 if you are a returning user and 2 to create a new account.'
  gets.chomp
end

def verify_user
  while true
    puts 'please enter username:'
    username = gets.chomp
    puts 'please enter password:'
    password = gets.chomp
    current_user = User.correct_password?(username, password)
    if current_user == false
      puts "Sorry #{username}, but that is not the correct password"\
    elsif current_user.nil?
      puts "Sorry, but #{username} is not a current user"
    elsif current_user != false && !current_user.nil?
      puts "Welcome back #{current_user.username}"
      return current_user
    end
  end
end

def create_user
  puts 'please enter username:'
  username = gets.chomp
  puts 'please enter password:'
  password = gets.chomp
  current_user = User.new_user(username, password)
  current_user
end

def log_in
  case greet
  when '1'
    current_user = verify_user
  when '2'
    current_user = create_user
  else
    puts 'Sorry, invalid input'
    log_in
  end
  return current_user
end
