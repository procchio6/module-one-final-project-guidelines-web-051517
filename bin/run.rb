#!/usr/bin/env ruby

require_relative '../config/environment'

def run
  current_user = log_in
  user_actions(current_user)
end
run
