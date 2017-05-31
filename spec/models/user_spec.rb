require_relative "../spec_helper"

describe User do
  describe "initialize" do
    it "has a username and password" do
      expect{User.new("username", "password")}.to_not raise_error
    end
  end
end
