class Shelter < ActiveRecord::Base
  has_many :pets

  validates :name, :location, :petfinder_id, presence: true
end
