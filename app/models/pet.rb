class Pet < ActiveRecord::Base
  ANIMAL_TYPES = %w(barnyard bird cat dog horse pig reptile smallfurry rabbit)
  AGES = %w(baby young adult senior)
  SEXES = %w(male female)
  SIZES = %w(small medium large extra-large)

  belongs_to :shelter
  has_many :faves
  has_many :users, through: :faves

  validates :animal_type, :name, presence: true
  validates :petfinder_id, uniqueness: true, allow_nil: true

  enum sex: SEXES
  enum age: AGES
  enum animal_type: ANIMAL_TYPES
  enum size: SIZES
end
