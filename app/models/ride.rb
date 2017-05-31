class Ride < ActiveRecord::Base
  attr_accessor :fare, :date

  belongs_to :user
  belongs_to :driver

  validates :fare, :date, presence: true

end
