require_relative "../spec_helper"

describe Ride do
  describe "new" do
    it "can create a new ride" do
      expect{Ride.new({fare:10.00})}.to_not raise_error
    end
  end
end
