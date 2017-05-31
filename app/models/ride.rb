class Ride < ActiveRecord::Base
  belongs_to :user
  belongs_to :driver

  validates :user_id, :driver_id, :fare, presence: true
end
