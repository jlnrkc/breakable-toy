class Shelter < ActiveRecord::Base
  has_many :pets

  validates :name, :location, presence: true
end
