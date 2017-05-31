require_relative "../spec_helper"

describe User do
  describe "new" do
    it "can create a new user with a username and password" do
      expect{User.new({username:"user", password:"pass"})}.to_not raise_error
    end
  end
end
