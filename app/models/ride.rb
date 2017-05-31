class Ride < ActiveRecord::Base
  belongs_to :user
  belongs_to :driver

  validates :fare, presence: true

end
