class Fave < ActiveRecord::Base
  belongs_to :user
  belongs_to :pet

  validates :pet_id, :user_id, presence: true
end
