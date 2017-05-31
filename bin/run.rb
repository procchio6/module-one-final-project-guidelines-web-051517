require_relative 'config/environment'

def run
  case greet
  when 1
    current_user = verify_user
  when 2
    current_user = create_user
  else
    puts "Sorry, invalid input"
    run
  end
end
